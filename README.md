# xxhash

a pure zig implementation of [xxhash](https://github.com/Cyan4973/xxHash)

## usage
see test/test.zig for usage examples

### preliminary benchmarks:

all benchmarks run on Broadwell Intel Core i7 3.1Ghz:

| load size | zig           | go (cespare)  |
| --------- | ------------- | ------------- |
| 8B        | 1219.90 MB/s  | 341.47 MB/s   |
| 64B       | 3362.59 MB/s  | 2495.76 MB/s  |
| 128B      | 5659.05 MB/s  | 4173.74 MB/s  |
| 4K        | 12485.72 MB/s | 11993.22 MB/s |  |

benchmark code is in the test folder