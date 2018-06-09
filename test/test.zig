const xxhash = @import("../src/xxhash.zig").xxhash;
const std = @import("std");
const debug = std.debug;
const assert = debug.assert;
const warn = debug.warn;

const test_data = struct {
    input: []const u8,
    sum: u64,

    pub fn init(sum: u64, input: []const u8) test_data {
        return test_data {
            .sum = sum,
            .input = input
        };
    }
};

fn sum_tests() [14]test_data {
    return []test_data{
        test_data.init(0xef46db3751d8e999, ""),
        test_data.init(0xd24ec4f1a98c6e5b, "a"),
        test_data.init(0x65f708ca92d04a61, "ab"),
        test_data.init(0x44bc2cf5ad770999, "abc"),
        test_data.init(0xde0327b0d25d92cc, "abcd"),
        test_data.init(0x07e3670c0c8dc7eb, "abcde"),
        test_data.init(0xfa8afd82c423144d, "abcdef"),
        test_data.init(0x1860940e2902822d, "abcdefg"),
        test_data.init(0x3ad351775b4634b7, "abcdefgh"),
        test_data.init(0x27f1a34fdbb95e13, "abcdefghi"),
        test_data.init(0xd6287a1de5498bb2, "abcdefghij"),
        test_data.init(0xbf2cd639b4143b80, "abcdefghijklmnopqrstuvwxyz012345"),
        test_data.init(0x64f23ecf1609b766, "abcdefghijklmnopqrstuvwxyz0123456789"),
        test_data.init(0xc5a8b11443765630, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
    };
}


test "xxhash.64.basic" {
    var data = sum_tests();

    for (data) |d, i| {
        var xx = xxhash.init(0);
        _ = xx.write(d.input);
        
        assert(xx.sum() == d.sum);
        assert(xx.checksum(d.input, 0) == d.sum);
    }
}
