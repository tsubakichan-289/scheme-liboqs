# scheme-liboqs

This project provides a simple Chicken Scheme wrapper for the
[liboqs](https://github.com/open-quantum-safe/liboqs) C library.  The wrapper
allows direct invocation of liboqs functions from Scheme using the native FFI.

This project is licensed under the MIT License; see the [LICENSE](LICENSE) file for details.

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

## Building the Scheme module

First build the small C wrapper that exposes a simplified API.  Link it
against `liboqs`:

```bash
$ gcc -fPIC -shared -I /usr/local/include \
      src/liboqs-wrapper.c -o liboqs-wrapper.so -loqs
```

Next compile the Scheme module itself, telling `csc` to use the wrapper
library and header:

```bash
$ csc -s -j liboqs -I src -I /usr/local/include \
      -L -L. -L -loqs-wrapper src/liboqs.scm
```

Keep the generated files in your load path (for example the current directory)
so the example can locate them.

## Using the wrapper

Compile the example program with `csc`, linking against the wrapper
library and previously compiled module:

```bash
$ csc -uses liboqs -I src -L -L. -L -loqs-wrapper \
      examples/demo.scm -o demo
$ LD_LIBRARY_PATH="/usr/local/lib:." ./demo
```

To compile the module and the demo in one invocation, pass both source files
to `csc`:

```bash
$ csc -s -j liboqs -I src -I /usr/local/include -L -L. -L -loqs-wrapper \
      src/liboqs.scm -uses liboqs examples/demo.scm -o demo
```

The `liboqs` module exposes helpers for creating a KEM object, generating
keypairs and performing encapsulation/decapsulation.
