//The best opensource license is no license at all - The OgreDotNet team

//%{
//#include "CEGUIIteratorBase.h"
//%}
//%include CEGUIIteratorBase.h

%nodefault CEGUI::ConstBaseIterator;

namespace CEGUI
{
    template <class T>
    class ConstBaseIterator
    {
     private:
         ConstBaseIterator();
     public:
        bool isAtStart(void) const;
        bool isAtEnd(void) const;
        void toStart(void);
        void toEnd(void);
    };
}



%define ConstBaseMapIteratorWRAP(name, T, X, Y)
%template(name) CEGUI::ConstBaseIterator<T <X, Y> >;
%extend CEGUI::ConstBaseIterator< T<X, Y> >
{
    X getCurrentKey(void)   { return self->getCurrentKey(); }
    Y getCurrentValue(void) { return self->getCurrentValue(); }
    void moveNext()         { ++(*self); }
    void movePrev()         { --(*self); }
    
#if defined(SWIGPYTHON)
    %pythoncode
    %{
        def __itr__(self):
            return self
        def next(self):
            if self.isAtEnd():
                raise StopIteration
            else:
                self.moveNext()
                return self.getCurrentKey(), self.getCurrentValue()
    %}
#elseif defined(SWIGCSHARP)
    %cscode %{
        public ConstBaseMapIteratorWRAP __iter__(ConstBaseIterator self)	{
            return self;
        }
        public Y next(ConstBaseIterator self){
            if (!self.isAtEnd()) {
              self.moveNext();
              return self.getCurrentValue();
            }
            else
                throw new Excption( "StopIteration" );
        }
    %}
#endif
};
%enddef

