/* -----------------------------------------------------------------------------
 * See the LICENSE file for information on copyright, usage and redistribution
 * of SWIG, and the README file for authors - http://www.swig.org/release.html.
 *
 * std_set.i
 *
 * SWIG typemaps for std::set
 * C# implementation
 * The C# wrapper is made to look and feel like a typesafe C# System.Collections.ArrayList
 * All the methods in IList are defined, but we don't derive from IList as this is a typesafe collection.
 * Warning: heavy macro usage in this file. Use swig -E to get a sane view on the real file contents!
 *
 * Very often the C# generated code will not compile as the C++ template type is not the same as the C# 
 * proxy type, so use the SWIG_STD_SET_SPECIALIZE or SWIG_STD_SET_SPECIALIZE_MINIMUM macro, eg
 *
 *   SWIG_STD_SET_SPECIALIZE_MINIMUM(Klass, SomeNamespace::Klass)
 *   %template(VectKlass) std::set<SomeNamespace::Klass>;
 * ----------------------------------------------------------------------------- */

// Warning: Use the typemaps here in the expectation that the macros they are in will change name.


%include <std_common.i>

// MACRO for use within the std::set class body
// CSTYPE and CTYPE respectively correspond to the types in the cstype and ctype typemaps
%define SWIG_STD_SET_MINIMUM(CSTYPE, CTYPE...)
%typemap(csinterfaces) std::set<CTYPE > "IDisposable, System.Collections.IEnumerable";
%typemap(cscode) std::set<CTYPE > %{
  public $csclassname(System.Collections.ICollection c) : this() {
    if (c == null)
      throw new ArgumentNullException("c");
    foreach (CSTYPE element in c) {
      this.insert(element);
    }
  }

  public bool IsFixedSize {
    get {
      return false;
    }
  }

  public bool IsReadOnly {
    get {
      return false;
    }
  }

  public CSTYPE this[int index]  {
    get {
      return getitem(index);
    }
  }

  public int Count {
    get {
      return (int)size();
    }
  }

  public bool IsSynchronized {
    get {
      return false;
    }
  }

  
  // Type-safe version of IEnumerable.GetEnumerator
  System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() {
    return new $csclassnameEnumerator(this);
  }

  public $csclassnameEnumerator GetEnumerator() {
    return new $csclassnameEnumerator(this);
  }

  // Type-safe enumerator
  /// Note that the IEnumerator documentation requires an InvalidOperationException to be thrown
  /// whenever the collection is modified. This has been done for changes in the size of the
  /// collection but not when one of the elements of the collection is modified as it is a bit
  /// tricky to detect unmanaged code that modifies the collection under our feet.
  public sealed class $csclassnameEnumerator : System.Collections.IEnumerator {
    private $csclassname collectionRef;
    private int currentIndex;
    private object currentObject;
    private int currentSize;

    public $csclassnameEnumerator($csclassname collection) {
      collectionRef = collection;
      currentIndex = -1;
      currentObject = null;
      currentSize = collectionRef.Count;
    }

    // Type-safe iterator Current
    public CSTYPE Current {
      get {
        if (currentIndex == -1)
          throw new InvalidOperationException("Enumeration not started.");
        if (currentIndex > currentSize - 1)
          throw new InvalidOperationException("Enumeration finished.");
        if (currentObject == null)
          throw new InvalidOperationException("Collection modified.");
        return (CSTYPE)currentObject;
      }
    }

    // Type-unsafe IEnumerator.Current
    object System.Collections.IEnumerator.Current {
      get {
        return Current;
      }
    }

    public bool MoveNext() {
      int size = collectionRef.Count;
      bool moveOkay = (currentIndex+1 < size) && (size == currentSize);
      if (moveOkay) {
        currentIndex++;
        currentObject = collectionRef[currentIndex];
      } else {
        currentObject = null;
      }
      return moveOkay;
    }

    public void Reset() {
      currentIndex = -1;
      currentObject = null;
      if (collectionRef.Count != currentSize) {
        throw new InvalidOperationException("Collection modified.");
      }
    }
  }
%}
    public:
        typedef size_t size_type;
        typedef CTYPE value_type;
        typedef const value_type& const_reference;
        size_type size() const;
        %newobject GetRange(int index, int count);
        set();
        %extend {
            const_reference getitem(int index) throw (std::out_of_range) {
                std::set<CTYPE >::iterator it= self->begin();
                std::advance(it,index);
                if (it != self->end())
                    return (*it);
                else
                    throw std::out_of_range("index");
            }
            // Takes a deep copy of the elements unlike ArrayList.AddRange
            void AddRange(const std::set<CTYPE >& values) {
                self->insert(values.begin(), values.end());
            }
            // Takes a deep copy of the elements unlike ArrayList.GetRange
            std::set<CTYPE > *GetRange(int index, int count) throw (std::out_of_range, std::invalid_argument) {
                if (index < 0)
                    throw std::out_of_range("index");
                if (count < 0)
                    throw std::out_of_range("count");
                if (index >= (int)self->size()+1 || index+count > (int)self->size())
                    throw std::invalid_argument("invalid range");

                std::set<CTYPE >::iterator it = self->begin();
                std::set<CTYPE >::iterator ite = self->begin();
                std::advance(ite,index);
                return new std::set<CTYPE >(it, ite);
            }
            //returns true if an insertion was make and false if the set already contained an element whose key had an equivalent value in the ordering.
            bool insert(const value_type& value)
            {
                std::pair< std::set<CTYPE >::iterator, bool > r= self->insert(value);
                return r.second;
            }
            void RemoveAt(int index) throw (std::out_of_range) {
                std::set<CTYPE >::iterator it = self->begin();
                std::advance(it,index);
                if (it != self->end())
                    self->erase(it);
                else
                    throw std::out_of_range("index");
            }
            void RemoveRange(int index, int count) throw (std::out_of_range, std::invalid_argument) {
                if (index < 0)
                    throw std::out_of_range("index");
                if (count < 0)
                    throw std::out_of_range("count");
                if (index >= (int)self->size()+1 || index+count > (int)self->size())
                    throw std::invalid_argument("invalid range");

                std::set<CTYPE >::iterator it = self->begin();
                std::set<CTYPE >::iterator ite = self->begin();
                std::advance(ite,index);
                self->erase(it, ite);
            }
    };
%enddef

// Extra methods added to the collection class if operator== is defined for the class being wrapped
// CSTYPE and CTYPE respectively correspond to the types in the cstype and ctype typemaps
%define SWIG_STD_SET_EXTRA_OP_EQUALS_EQUALS(CSTYPE, CTYPE...)
    %extend {
      bool Contains(const value_type& value) {
        return std::find(self->begin(), self->end(), value) != self->end();
      }
      int IndexOf(const value_type& value) {
        int index = -1;
        std::set<CTYPE >::iterator it = std::find(self->begin(), self->end(), value);
        if (it != self->end())
          index = (int)std::distance(self->begin(), it);
        return index;
      }
      int LastIndexOf(const value_type& value) {
        int index = -1;
        std::set<CTYPE >::reverse_iterator rit = std::find(self->rbegin(), self->rend(), value);
        if (rit != self->rend())
          index = (int)std::distance(rit, --(self->rend()));
        return index;
      }
      void Remove(const value_type& value) {
        std::set<CTYPE >::iterator it = std::find(self->begin(), self->end(), value);
        if (it != self->end())
          self->erase(it);
      }
    }
%enddef

// Macros for std::set class specializations
// CSTYPE and CTYPE respectively correspond to the types in the cstype and ctype typemaps
%define SWIG_STD_SET_SPECIALIZE(CSTYPE, CTYPE...)
namespace std {
  template<> class set<CTYPE > {
    SWIG_STD_SET_MINIMUM(CSTYPE, CTYPE)
    SWIG_STD_SET_EXTRA_OP_EQUALS_EQUALS(CSTYPE, CTYPE)
  };
}
%enddef

%define SWIG_STD_SET_SPECIALIZE_MINIMUM(CSTYPE, CTYPE...)
namespace std {
  template<> class set<CTYPE > {
    SWIG_STD_SET_MINIMUM(CSTYPE, CTYPE)
  };
}
%enddef

%{
#include <set>
#include <algorithm>
#include <stdexcept>
%}

%csmethodmodifiers std::set::getitem "private"
%csmethodmodifiers std::set::size "private"

namespace std {
  // primary (unspecialized) class template for std::set
  // does not require operator== to be defined
  template<class T> class set {
    SWIG_STD_SET_MINIMUM(T, T)
  };
  // specializations for pointers
  template<class T> class set<T*> {
    SWIG_STD_SET_MINIMUM(T, T*)
  };
  template<class T> class set<const T*> {
    SWIG_STD_SET_MINIMUM(T, const T*)
  };
}

// template specializations for std::set
// these provide extra collections methods as operator== is defined
SWIG_STD_SET_SPECIALIZE(bool, bool)
SWIG_STD_SET_SPECIALIZE(char, char)
SWIG_STD_SET_SPECIALIZE(sbyte, signed char)
SWIG_STD_SET_SPECIALIZE(byte, unsigned char)
SWIG_STD_SET_SPECIALIZE(short, short)
SWIG_STD_SET_SPECIALIZE(ushort, unsigned short)
SWIG_STD_SET_SPECIALIZE(int, int)
SWIG_STD_SET_SPECIALIZE(uint, unsigned int)
SWIG_STD_SET_SPECIALIZE(int, long)
SWIG_STD_SET_SPECIALIZE(uint, unsigned long)
SWIG_STD_SET_SPECIALIZE(long, long long)
SWIG_STD_SET_SPECIALIZE(ulong, unsigned long long)
SWIG_STD_SET_SPECIALIZE(float, float)
SWIG_STD_SET_SPECIALIZE(double, double)
SWIG_STD_SET_SPECIALIZE(string, std::string) // also requires a %include <std_string.i>


