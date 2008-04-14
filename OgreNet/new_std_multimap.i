//
// SWIG typemaps for std::multimap
// Luigi Ballabio
// Jan. 2003
//
// Common implementation

%include <std_common.i>

// ------------------------------------------------------------------------
// std::multimap
// ------------------------------------------------------------------------

%{
#include <map>
#include <algorithm>
#include <stdexcept>
%}

// exported class

namespace std {

    template<class K, class T> class multimap {
        // add typemaps here
      public:
        multimap();
        multimap(const multimap<K,T> &);
        
        unsigned int size() const;
        bool empty() const;
        void clear();
        %extend {
            T& get(const K& key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    return i->second;
                else
                    throw std::out_of_range("key not found");
            }
            void set(const K& key, const T& x)
            {
              self->insert(std::pair< K, T>(key, x));
            }
            void del(const K& key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    self->erase(i);
                else
                    throw std::out_of_range("key not found");
            }
            bool has_key(const K& key)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                return i != self->end();
            }
            T& getitemValue(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (T&)it->second;
                }
                else
                    throw std::out_of_range("index");
            }
            K& getitemKey(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (K&)it->first;
                }
                else
                    throw std::out_of_range("index");
            }
        }
    };


    // specializations for built-ins

    %define specialize_std_multimap_on_key(K,CHECK,CONVERT_FROM,CONVERT_TO)

    template<class T> class multimap<K,T> {
        // add typemaps here
      public:
        multimap();
        multimap(const multimap<K,T> &);
        
        unsigned int size() const;
        bool empty() const;
        void clear();
        %extend {
            T& get(K key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    return i->second;
                else
                    throw std::out_of_range("key not found");
            }
            void set(K key, const T& x)
            {
                (*self)[key] = x;
            }
            void del(K key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    self->erase(i);
                else
                    throw std::out_of_range("key not found");
            }
            bool has_key(K key)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                return i != self->end();
            }
            T& getitemValue(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (T&)it->second;
                }
                else
                    throw std::out_of_range("index");
            }
            K& getitemKey(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (K&)it->first;
                }
                else
                    throw std::out_of_range("index");
            }
        }
    };
    %enddef

    %define specialize_std_multimap_on_value(T,CHECK,CONVERT_FROM,CONVERT_TO)
    template<class K> class multimap<K,T> {
        // add typemaps here
      public:
        multimap();
        multimap(const multimap<K,T> &);
        
        unsigned int size() const;
        bool empty() const;
        void clear();
        %extend {
            T get(const K& key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    return i->second;
                else
                    throw std::out_of_range("key not found");
            }
            void set(const K& key, T x)
            {
                (*self)[key] = x;
            }
            void del(const K& key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    self->erase(i);
                else
                    throw std::out_of_range("key not found");
            }
            bool has_key(const K& key)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                return i != self->end();
            }
            T& getitemValue(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (T&)it->second;
                }
                else
                    throw std::out_of_range("index");
            }
            K& getitemKey(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (K&)it->first;
                }
                else
                    throw std::out_of_range("index");
            }
        }
    };
    %enddef

    %define specialize_std_multimap_on_both(K,CHECK_K,CONVERT_K_FROM,CONVERT_K_TO,
                                       T,CHECK_T,CONVERT_T_FROM,CONVERT_T_TO)
    template<> class multimap<K,T> {
        // add typemaps here
      public:
        multimap();
        multimap(const multimap<K,T> &);
        
        unsigned int size() const;
        bool empty() const;
        void clear();
        %extend {
            T get(K key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    return i->second;
                else
                    throw std::out_of_range("key not found");
            }
            void set(K key, T x)
            {
                (*self)[key] = x;
            }
            void del(K key) throw (std::out_of_range)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                if (i != self->end())
                    self->erase(i);
                else
                    throw std::out_of_range("key not found");
            }
            bool has_key(K key)
            {
                std::multimap<K,T >::iterator i = self->find(key);
                return i != self->end();
            }
            T& getitemValue(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (T&)it->second;
                }
                else
                    throw std::out_of_range("index");
            }
            K& getitemKey(int index) throw (std::out_of_range)
            {
                if (index>=0 && index<(int)self->size())
                {
                    std::multimap<K,T >::iterator it = (*self).begin();
                    std::advance(it,index);
                    return  (K&)it->first;
                }
                else
                    throw std::out_of_range("index");
            }
        }
    };
    %enddef

    // add specializations here
}
