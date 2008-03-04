/* MapIterator, ConstMapIterator from pyOgre
 * TODO:
 * - Wrap all the missing wrappers.
 * - Maybe find a better way that does not require the macro with the three
 *   different types? 
 *
 * - see OgreAnimation.i for pointer error fix
 *     old - ConstMapIterator seems to cause a pointer error.  Fix this and un %ignore
 *           getTrackIterator in OgreAnimation.i.
 */
 
namespace Ogre
{
    template <class T>
    class MapIterator
    {
    private:
        MapIterator();

    public:
        //MapIterator(typename T::iterator start, typename T::iterator end);
        bool hasMoreElements(void) const;
        void moveNext(void);
    };
    
    template <class T>
    class ConstMapIterator
    {
    private:
        ConstMapIterator();

    public:
        //ConstMapIterator(typename T::iterator start, typename T::iterator end);
        bool hasMoreElements(void) const;
        void moveNext(void);
    };
    
    template <class T>
    class VectorIterator
    {
    private:
        VectorIterator();
    public:
        //VectorIterator(typename T::iterator start, typename T::iterator end);
        bool hasMoreElements(void) const;
        void moveNext(void);
    };
    
    template <class T>
    class ConstVectorIterator
    {
    private:
        ConstVectorIterator();
    public:
        //ConstVectorIterator(typename T::const_iterator start, typename T::const_iterator end);
        bool hasMoreElements(void) const;
        void moveNext(void) const;
    };
}

%define MapIteratorWRAP(name, T, X, Y)
%template(name) Ogre::MapIterator<T <X, Y> >;
%extend Ogre::MapIterator< T<X, Y> >
{
    X peekNextKey(void)   { return self->peekNextKey(); }
    Y peekNextValue(void) { return self->peekNextValue(); }
    Y getNext(void)       { return self->getNext(); }

#if defined(SWIGPYTHON)
    %pythoncode %{
        def __iter__(self):
            return self
        def next(self):
            if self.hasMoreElements():
                return self.peekNextKey(), self.getNext()
            else:
                raise StopIteration
    %}
#elseif defined(SWIGCSHARP)
    %cscode %{
        public MapIterator __iter__(MapIterator self)    {
            return self;
        }
        public Y next(MapIterator self){
            if (self.hasMoreElements())
                return self.getNext();
            else
                throw new Exception("StopIteration");
        }
    %}
#endif
};
%enddef

%define ConstMapIteratorWRAP(name, T, X, Y)
%template(name) Ogre::ConstMapIterator<T <X, Y> >;
%extend Ogre::ConstMapIterator< T<X, Y> >
{
    X peekNextKey(void)   { return self->peekNextKey(); }
    Y peekNextValue(void) { return self->peekNextValue(); }
    Y getNext(void)       { return self->getNext(); }
    
#if defined(SWIGPYTHON)
    %pythoncode
    %{
        def __itr__(self):
            return self
        def next(self):
            if self.hasMoreElements():
                return self.peekNextKey(), self.getNext()
            else:
                raise StopIteration
    %}
#elseif defined(SWIGCSHARP)
    %cscode %{
        public ConstMapIteratorWRAP __iter__(ConstMapIteratorWRAP self)    {
            return self;
        }
        public Y next(ConstMapIteratorWRAP self){
            if (self.hasMoreElements())
                return self.getNext();
            else
                throw new Exception("StopIteration");
        }
    %}
#endif
};
%enddef

%define VectorIteratorWRAP(name, T, X)
%template(name) Ogre::VectorIterator<T <X> >;
%extend Ogre::VectorIterator< T<X> >
{
    X peekNext(void)   { return self->peekNext(); }
    X getNext(void)    { return self->getNext(); }

#if defined(SWIGPYTHON)
    %pythoncode %{
        def __iter__(self):
            return self
        def next(self):
            if self.hasMoreElements():
                return self.getNext()
            else:
                raise StopIteration
    %}
#elseif defined(SWIGCSHARP)
    %cscode %{
        public VectorIterator __iter__(VectorIterator self)    {
            return self;
        }
        public X next(VectorIterator self){
            if (self.hasMoreElements())
                return self.getNext();
            else
                throw new Exception("StopIteration");
        }
    %}
#endif
};
%enddef

%define ConstVectorIteratorWRAP(name, T, X)
%template(name) Ogre::ConstVectorIterator<T <X> >;
%extend Ogre::ConstVectorIterator< T<X> >
{
    X peekNext(void)   { return self->peekNext(); }
    X getNext(void)    { return self->getNext(); }

#if defined(SWIGPYTHON)
    %pythoncode %{
        def __iter__(self):
            return self
        def next(self):
            if self.hasMoreElements():
                return self.getNext()
            else:
                raise StopIteration
    %}
#elseif defined(SWIGCSHARP)
    %cscode %{
        public ConstVectorIterator __iter__(ConstVectorIterator self)    {
            return self;
        }
        public X next(ConstVectorIterator self){
            if (self.hasMoreElements())
                return self.getNext();
            else
                throw new Exception("StopIteration");
        }
    %}
#endif
};
%enddef
