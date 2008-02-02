#include "CEGUI.h"
#include <iostream>	//for std::cout testing

using namespace CEGUI;

typedef CEGUI::uint32 UTF32;
typedef CEGUI::uint16 UTF16;
typedef CEGUI::utf8 UTF8;

/* Some fundamental constants */
#define UNI_REPLACEMENT_CHAR (UTF32)0x0000FFFD
#define UNI_MAX_BMP (UTF32)0x0000FFFF
#define UNI_MAX_UTF16 (UTF32)0x0010FFFF
#define UNI_MAX_UTF32 (UTF32)0x7FFFFFFF
#define UNI_MAX_LEGAL_UTF32 (UTF32)0x0010FFFF


static const int halfShift  = 10; /* used for shifting by 10 bits */

static const UTF32 halfBase = 0x0010000UL;
static const UTF32 halfMask = 0x3FFUL;

#define UNI_SUR_HIGH_START  (UTF32)0xD800
#define UNI_SUR_HIGH_END    (UTF32)0xDBFF
#define UNI_SUR_LOW_START   (UTF32)0xDC00
#define UNI_SUR_LOW_END     (UTF32)0xDFFF



/*
 * Index into the table below with the first byte of a UTF-8 sequence to
 * get the number of trailing bytes that are supposed to follow it.
 * Note that *legal* UTF-8 values can't have 4 or 5-bytes. The table is
 * left as-is for anyone who may want to do such conversion, which was
 * allowed in earlier algorithms.
 */
static const char trailingBytesForUTF8[256] = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
};

/*
 * Magic values subtracted from a buffer value during UTF8 conversion.
 * This table contains as many values as there might be trailing bytes
 * in a UTF-8 sequence.
 */
static const UTF32 offsetsFromUTF8[6] = { 0x00000000UL, 0x00003080UL, 0x000E2080UL, 
		     0x03C82080UL, 0xFA082080UL, 0x82082080UL };

/*
 * Once the bits are split out into bytes of UTF-8, this is a mask OR-ed
 * into the first byte, depending on how many bytes follow.  There are
 * as many entries in this table as there are UTF-8 sequence types.
 * (I.e., one byte sequence, two byte... etc.). Remember that sequencs
 * for *legal* UTF-8 will be 4 or fewer bytes total.
 */
static const UTF8 firstByteMark[7] = { 0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC };


//---------------------------------
//convert UTF-16 to UTF-8  for the "utf8 *" typmape

size_t findSizeUTF16( const UTF16** sourceStart, UTF16** outptrEnd )
{
	size_t count=0;
	const UTF16* sourceEnd = *sourceStart;
	while (*sourceEnd++)
		count++;
	
	if (outptrEnd)
		*outptrEnd = (UTF16*)--sourceEnd;
	return count;
}

size_t findSizeUTF8( const UTF8** sourceStart, UTF8** outptrEnd )
{
	size_t count=0;
	const UTF8* sourceEnd = *sourceStart;
	while (*sourceEnd++)
		count++;
	
	if (outptrEnd)
		*outptrEnd = (UTF8*)--sourceEnd;
	return count;
}


int ConvertUTF16toUTF8 (
	const UTF16** sourceStart, const UTF16* sourceEnd, 
	CEGUI::String *strTarget, bool strictConversion)
{
	int result = 0;
	const UTF16* source = *sourceStart;
	UTF8 targetBuff[5], *target;
    //std::cout << "-- ConvertUTF16toUTF8 : sS " << (CEGUI::ulong)*sourceStart
    //  << " sE " << (CEGUI::ulong)sourceEnd
    //  << " tS " << (CEGUI::ulong)*targetStart
    //  << " tE " << (CEGUI::ulong)targetEnd  << std::endl;
      
	while (source < sourceEnd)	{
		UTF32 ch;
		unsigned short bytesToWrite = 0;
		const UTF32 byteMask = 0xBF;
		const UTF32 byteMark = 0x80; 
		const UTF16* oldSource = source; /* In case we have to back up because of target overflow. */
		ch = *source++;
		/* If we have a surrogate pair, convert to UTF32 first. */
		if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_HIGH_END)	{
			/* If the 16 bits following the high surrogate are in the source buffer... */
			if (source < sourceEnd)	{
				UTF32 ch2 = *source;
				/* If it's a low surrogate, convert to UTF32. */
				if (ch2 >= UNI_SUR_LOW_START && ch2 <= UNI_SUR_LOW_END)	{
					ch = ((ch - UNI_SUR_HIGH_START) << halfShift)
						+ (ch2 - UNI_SUR_LOW_START) + halfBase;
					++source;
				}
				else if (strictConversion)	{
					/* it's an unpaired high surrogate */
					--source; /* return to the illegal value itself */
					result = 3;
					break;
				}
			}
			else	{
				/* We don't have the 16 bits following the high surrogate. */
				--source; /* return to the high surrogate */
				result = 1;
				break;
			}
		}
		else if (strictConversion)	{
			/* UTF-16 surrogate values are illegal in UTF-32 */
			if (ch >= UNI_SUR_LOW_START && ch <= UNI_SUR_LOW_END)	{
				--source; /* return to the illegal value itself */
				result = 3;
				break;
			}
		}
		/* Figure out how many bytes the result will require */
		if (ch < (UTF32)0x80)	{
			bytesToWrite = 1;
		}
		else if (ch < (UTF32)0x800)	{
			bytesToWrite = 2;
		}
		else if (ch < (UTF32)0x10000)	{
			bytesToWrite = 3;
		}
		else if (ch < (UTF32)0x110000)	{
			bytesToWrite = 4;
		}
		else	{
			bytesToWrite = 3;
			ch = UNI_REPLACEMENT_CHAR;
		}
		
		targetBuff[0]=(UTF8)0;
		targetBuff[1]=(UTF8)0;
		targetBuff[2]=(UTF8)0;
		targetBuff[3]=(UTF8)0;
		targetBuff[4]=(UTF8)0;
		target = targetBuff + bytesToWrite;
		switch (bytesToWrite) { /* note: everything falls through. */
		case 4: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
		case 3: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
		case 2: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
		case 1: *--target =  (UTF8)(ch | firstByteMark[bytesToWrite]);
		}
		(*strTarget) += (CEGUI::utf8 *)target;
	}
	*sourceStart = source;
	return result;
}


/*
 * Utility routine to tell whether a sequence of bytes is legal UTF-8.
 * This must be called with the length pre-determined by the first byte.
 * If not calling this from ConvertUTF8to*, then the length can be set by:
 *  length = trailingBytesForUTF8[*source]+1;
 * and the sequence is illegal right away if there aren't that many bytes
 * available.
 * If presented with a length > 4, this returns false.  The Unicode
 * definition of UTF-8 goes up to 4-byte sequences.
 */

static bool isLegalUTF8(const UTF8 *source, int length) {
    UTF8 a;
    const UTF8 *srcptr = source+length;
    switch (length) {
    default: return false;
	/* Everything else falls through when "true"... */
    case 4: if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return false;
    case 3: if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return false;
    case 2: if ((a = (*--srcptr)) > 0xBF) return false;

	switch (*source) {
	    /* no fall-through in this inner switch */
	    case 0xE0: if (a < 0xA0) return false; break;
	    case 0xED: if (a > 0x9F) return false; break;
	    case 0xF0: if (a < 0x90) return false; break;
	    case 0xF4: if (a > 0x8F) return false; break;
	    default:   if (a < 0x80) return false;
	}

    case 1: if (*source >= 0x80 && *source < 0xC2) return false;
    }
    if (*source > 0xF4) return false;
    return true;
}


int ConvertUTF8toUTF16 (
	const UTF8** sourceStart, const UTF8* sourceEnd, 
	UTF16** targetStart, UTF16* targetEnd, bool strictConversion)
{
	int result = 0;
	const UTF8* source = *sourceStart;
	UTF16* target = *targetStart;
	while (source < sourceEnd)
	{
		UTF32 ch = 0;
		unsigned short extraBytesToRead = trailingBytesForUTF8[*source];
		if (source + extraBytesToRead >= sourceEnd) {
			result = 1;
			break;
		}
		/* Do this check whether lenient or strict */
		if (! isLegalUTF8(source, extraBytesToRead+1)) {
			result = 3;
			break;
		}
		/*
		* The cases all fall through. See "Note A" below.
		*/
		switch (extraBytesToRead) {
			case 5: ch += *source++; ch <<= 6; /* remember, illegal UTF-8 */
			case 4: ch += *source++; ch <<= 6; /* remember, illegal UTF-8 */
			case 3: ch += *source++; ch <<= 6;
			case 2: ch += *source++; ch <<= 6;
			case 1: ch += *source++; ch <<= 6;
			case 0: ch += *source++;
		}
		ch -= offsetsFromUTF8[extraBytesToRead];
		
		if (target >= targetEnd) {
			source -= (extraBytesToRead+1); /* Back up source pointer! */
			result = 2;
			break;
		}
		if (ch <= UNI_MAX_BMP) {
			/* Target is a character <= 0xFFFF */
			/* UTF-16 surrogate values are illegal in UTF-32 */
			if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
				if (strictConversion) {
					source -= (extraBytesToRead+1); /* return to the illegal value itself */
					result = 3;
					break;
				}
				else {
					*target++ = UNI_REPLACEMENT_CHAR;
				}
			}
			else {
				*target++ = (UTF16)ch; /* normal case */
			}
		}
		else if (ch > UNI_MAX_UTF16) {
			if (strictConversion) {
				result = 3;
				source -= (extraBytesToRead+1); /* return to the start */
				break; /* Bail out; shouldn't continue */
			}
			else {
				*target++ = UNI_REPLACEMENT_CHAR;
			}
		}
		else {
			/* target is a character in range 0xFFFF - 0x10FFFF. */
			if (target + 1 >= targetEnd) {
			source -= (extraBytesToRead+1); /* Back up source pointer! */
			result = 2;
			break;
			}
			ch -= halfBase;
			*target++ = (UTF16)((ch >> halfShift) + UNI_SUR_HIGH_START);
			*target++ = (UTF16)((ch & halfMask) + UNI_SUR_LOW_START);
		}
	}
	*sourceStart = source;
	*targetStart = target;
	return result;
}


const CEGUI::utf8 *work_UTF16_UTF8( const UTF16* inUTF16)
{
	static CEGUI::String sHold;
	sHold = "";

	//std::cout << "-- work_UTF16_UTF8: jarg1=" << (const char*)jarg1 << std::endl;
	//for (int i=0; i<10; i++)
	//	std::cout << "-- work_UTF16_UTF8: jarg1[" << i << "]="
	//	<< (int)((const char*)jarg1)[i]
	//	<< "  " << (char)((const char*)jarg1)[i] << std::endl;

	UTF16 *sourceStart=(UTF16 *)inUTF16, *sourceEnd=0;

	size_t SizeOfSource = findSizeUTF16( (const UTF16**)&sourceStart, &sourceEnd);
	//std::cout << "-- work_UTF16_UTF8: findSizeUTF16=" << SizeOfSource << std::endl;

	int OK = ConvertUTF16toUTF8( (const UTF16**)&sourceStart, sourceEnd, &sHold, false );
	if (OK !=0) {
		std::cout << "-- work_UTF16_UTF8: NOT ok return " << OK << " sHold=" << (const char*)sHold.c_str() << std::endl;
		sHold = (CEGUI::utf8 *)inUTF16;
	}
	else {
		//std::cout << "-- work_UTF16_UTF8: ok sHold=" << (const char*)sHold.c_str() << std::endl;
		//for (int i=0; i<10; i++)
		//  std::cout << "-- work_UTF16_UTF8: sHold.c_str()[" << i << "]=" 
		//	<< (int)((const char*)sHold.c_str())[i]
		//	<< "  " << (char)((const char*)sHold.c_str())[i] << std::endl;
	}
	return (const CEGUI::utf8 *)sHold.c_str();
}



//---------------------------------
//convert UTF-32 to UTF-8  for the "utf8 *" typmape


size_t findSizeUTF32( const UTF32** sourceStart, UTF32** outptrEnd )
{
	size_t count=0;
	const UTF32* sourceEnd = *sourceStart;
	while (*sourceEnd++)
		count++;
	
	if (outptrEnd)
		*outptrEnd = (UTF32*)--sourceEnd;
	return count;
}


int ConvertUTF32toUTF8 (
	const UTF32** sourceStart, const UTF32* sourceEnd, 
	CEGUI::String *strTarget, bool strictConversion)
{
	int result = 0;
	const UTF32* source = *sourceStart;
	UTF8 targetBuff[5], *target;

	while (source < sourceEnd)
	{
		UTF32 ch;
		unsigned short bytesToWrite = 0;
		const UTF32 byteMask = 0xBF;
		const UTF32 byteMark = 0x80; 
		ch = *source++;
		if (strictConversion ) {
			/* UTF-16 surrogate values are illegal in UTF-32 */
			if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
				--source; /* return to the illegal value itself */
				result = 3;
				break;
			}
		}
		/*
		* Figure out how many bytes the result will require. Turn any
		* illegally large UTF32 things (> Plane 17) into replacement chars.
		*/
		if (ch < (UTF32)0x80) {
			bytesToWrite = 1;
		}
		else if (ch < (UTF32)0x800) {
			bytesToWrite = 2;
		}
		else if (ch < (UTF32)0x10000) {
			bytesToWrite = 3;
		}
		else if (ch <= UNI_MAX_LEGAL_UTF32) {
			bytesToWrite = 4;
		}
		else {
			bytesToWrite = 3;
			ch = UNI_REPLACEMENT_CHAR;
			result = 3;
		}
		
		targetBuff[0]=(UTF8)0;
		targetBuff[1]=(UTF8)0;
		targetBuff[2]=(UTF8)0;
		targetBuff[3]=(UTF8)0;
		targetBuff[4]=(UTF8)0;
		target = targetBuff + bytesToWrite;
		switch (bytesToWrite) { /* note: everything falls through. */
			case 4: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
			case 3: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
			case 2: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
			case 1: *--target = (UTF8) (ch | firstByteMark[bytesToWrite]);
		}
		(*strTarget) += (CEGUI::utf8 *)target;
	}
	*sourceStart = source;
	return result;
}


int ConvertUTF8toUTF32 (
	const UTF8** sourceStart, const UTF8* sourceEnd, 
	UTF32** targetStart, UTF32* targetEnd, bool strictConversion)
{
	int result = 0;
	const UTF8* source = *sourceStart;
	UTF32* target = *targetStart;

	//std::cout << "sizeof(UTF8)=" << sizeof(UTF8) << " sizeof(UTF16)=" << sizeof(UTF16) << " sizeof(UTF32)=" << sizeof(UTF32) << std::endl;

	while (source < sourceEnd)
	{
		UTF32 ch = 0;
		unsigned short extraBytesToRead = trailingBytesForUTF8[*source];
		if (source + extraBytesToRead >= sourceEnd) {
			result = 1;
			break;
		}
		/* Do this check whether lenient or strict */
		if (! isLegalUTF8(source, extraBytesToRead+1)) {
			result = 3;
			break;
		}
		/*
		* The cases all fall through. See "Note A" below.
		*/
		switch (extraBytesToRead) {
			case 5: ch += *source++; ch <<= 6;
			case 4: ch += *source++; ch <<= 6;
			case 3: ch += *source++; ch <<= 6;
			case 2: ch += *source++; ch <<= 6;
			case 1: ch += *source++; ch <<= 6;
			case 0: ch += *source++;
		}
		ch -= offsetsFromUTF8[extraBytesToRead];
		
		if (target >= targetEnd) {
			source -= (extraBytesToRead+1); /* Back up the source pointer! */
			result = 2;
			break;
		}
		if (ch <= UNI_MAX_LEGAL_UTF32) {
			/*
			* UTF-16 surrogate values are illegal in UTF-32, and anything
			* over Plane 17 (> 0x10FFFF) is illegal.
			*/
			if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
				if (strictConversion) {
					source -= (extraBytesToRead+1); /* return to the illegal value itself */
					result = 3;
					break;
				}
				else {
					*target++ = UNI_REPLACEMENT_CHAR;
				}
			}
			else {
				*target++ = ch;
			}
		}
		else {
			/* i.e., ch > UNI_MAX_LEGAL_UTF32 */
			result = 3;
			*target++ = UNI_REPLACEMENT_CHAR;
		}
	}
	*sourceStart = source;
	*targetStart = target;
	return result;
}


const CEGUI::utf8 *work_UTF32_UTF8( const UTF32* inUTF32)
{
	static CEGUI::String sHold;
	sHold = "";

	//std::cout << "-- work_UTF32_UTF8: jarg1=" << (const char*)jarg1 << std::endl;
	//for (int i=0; i<10; i++)
	//	std::cout << "-- work_UTF32_UTF8: jarg1[" << i << "]=" << (int)((const char*)jarg1)[i] << "  " << (char)((const char*)jarg1)[i] << std::endl;

	UTF32 *sourceStart=(UTF32 *)inUTF32, *sourceEnd=0;

	size_t newbuffsize = findSizeUTF32( (const UTF32**)&sourceStart, &sourceEnd);
	//std::cout << "-- work_UTF16_UTF8: findSizeUTF16=" << SizeOfSource << std::endl;

	int OK = ConvertUTF32toUTF8( (const UTF32**)&sourceStart, sourceEnd, &sHold, false );
	if (OK !=0) {
		std::cout << "-- work_UTF32_UTF8: NOT ok return " << OK << " sHold=" << (const char*)sHold.c_str() << std::endl;
		sHold = (CEGUI::utf8 *)inUTF32;
	}
	else {
		//std::cout << "-- work_UTF32_UTF8: ok sHold=" << (const char*)sHold.c_str() << std::endl;
		//for (int i=0; i<10; i++)
		//  std::cout << "-- work_UTF32_UTF8: sHold.c_str()[" << i << "]=" 
		//	<< (int)((const char*)sHold.c_str())[i]
		//	<< "  " << (char)((const char*)sHold.c_str())[i] << std::endl;
	}
	return (const CEGUI::utf8 *)sHold.c_str();
}
