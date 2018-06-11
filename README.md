# xxhash

a pure zig implementation of [xxhash](https://github.com/Cyan4973/xxHash)

## usage
see test/test.zig for usage examples

### preliminary benchmarks:

all benchmarks run on Broadwell Intel Core i7 3.1Ghz:

| load size | zig           | c (reference) | go (cespare)  |
| --------- | ------------- | ------------- | ------------- |
| 8B        | 2013.66 MB/s  | 6467.59 MB/s  | 353.81 MB/s   |
| 64B       | 4029.037 MB/s | 3537.34 MB/s  | 2551.29 MB/s  |
| 128B      | 6199.02 MB/s  | 5576.20 MB/s  | 4292.74 MB/s  |
| 4K        | 12587.76 MB/s | 12540.50 MB/s | 12126.35 MB/s |  |

benchmark code is in the test folder