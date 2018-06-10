# xxhash

a pure zig implementation of [xxhash](https://github.com/Cyan4973/xxHash)

## usage
see test/test.zig for usage examples

### preliminary benchmarks:

all benchmarks run on Broadwell Intel Core i7 3.1Ghz:

| load size | zig           | go (cespare)  |
| --------- | ------------- | ------------- |
| 8B        | 1915.17 MB/s  | 353.81 MB/s   |
| 64B       | 3929.87 MB/s  | 2551.29 MB/s  |
| 128B      | 6199.02 MB/s  | 4292.74 MB/s  |
| 4K        | 12403.13 MB/s | 12126.35 MB/s |  |

benchmark code is in the test folder