# benchmarks


### zig 

```
$ zig run --release-fast bench.zig
```

### c

```
$ git clone https://github.com/Cyan4973/xxHash.git
$ clang -flto -O3 xxHash/xxhash.c bench.c -o cbench
$ ./cbench
```

### go

```
$ go run bench.go
```