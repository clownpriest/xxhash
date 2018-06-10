# benchmarks


### zig 

```
$ zig run --release-fast bench.zig
```

### c

```
$ clang bench.c -O3 -lxxhash -o cbench
$ ./cbench
```
### go

```
$ go run bench.go
```