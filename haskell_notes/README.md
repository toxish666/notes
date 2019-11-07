# Haskell notes

Root destination for all notes made on haskell.

Attempts to structurize somehow any readed articles/repos to future reference. 


## Build tools and other related stuff

[Snack](https://github.com/nmattia/snack) is a nix-based incremental build tool for Haskell projects;
it uses [hpack](https://github.com/sol/hpack) as a format for it's packages.




## Generics (and Data, Typeable)

[GHC Generics Explained](https://www.stackbuilders.com/tutorials/haskell/generics/)  --  intro into generics.
[Typeable and Data in Haskell](https://chrisdone.com/posts/data-typeable/)  --  intro into typeable and data.

### Implementations, uses

[generics-sop](https://github.com/well-typed/generics-sop)  ---  library to support the definition of generic functions. Datatypes are viewed in a uniform, structured way: the choice between constructors is represented using an n-ary sum, and the arguments of each constructor are represented using an n-ary product

## Lenses

[Glassery](http://oleg.fi/gists/posts/2017-04-18-glassery.html)  --  gathering and classifying all possible optic types

### Implementations, uses
[optics](https://github.com/well-typed/optics)  ---  the optics family of Haskell packages make it possible to define and use Lenses, Traversals, Prisms and other optics, using an abstract interface. They are roughly comparable in functionality with the lens package, but explore a different part of the design space.



## Style 
[Haskell Style Guide](https://kowainik.github.io/posts/2019-02-06-style-guide)





## Blogs
[Oleg Grenrus's blog](http://oleg.fi/gists/) great in-depth topics (not begginer-friendly, updated quite often)
[Chris Done's blog](https://chrisdone.com/posts/) 
[Kowainik blog](https://kowainik.github.io/posts)
