# scheme-liboqs

This project provides a simple Chicken Scheme wrapper for the
[liboqs](https://github.com/open-quantum-safe/liboqs) C library.  The wrapper
allows direct invocation of liboqs functions from Scheme using the native FFI.

## Building liboqs

liboqs is not included in this repository.  Obtain and build the library
separately, for example:

```bash
$ git clone https://github.com/open-quantum-safe/liboqs.git
$ cd liboqs
$ mkdir build && cd build
$ cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON ..
$ ninja
$ sudo make install    # or copy `lib/liboqs.so` to a reachable location
```

Ensure `liboqs.so` is in your library search path or set `LD_LIBRARY_PATH`
accordingly.

## Using the wrapper

Compile the example program with `csc`, passing the library path via `-L` if
needed:

```bash
$ csc -I /usr/local/include -L -loqs examples/demo.scm -o demo
$ LD_LIBRARY_PATH=/usr/local/lib ./demo
```

The `liboqs` module exposes helpers for creating a KEM object, generating
keypairs and performing encapsulation/decapsulation.
