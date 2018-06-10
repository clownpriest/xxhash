const xxhash = @import("../src/xxhash.zig").xxhash;

const std = @import("std");
const io = std.io;
const warn = std.debug.warn;
const time = std.os.time;
const Timer = time.Timer;
const rand = std.rand;
const mem = std.mem;


fn bench(payload: []const u8) !f64 {
    var xx = xxhash.init(0);
    var i: usize = 0;

    const iteration_count: usize = 1000000;
    var results: [iteration_count]u64 = undefined;

    var timer = try Timer.start();
    const start = timer.lap();

    while (i < iteration_count): (i += 1) {
        results[i] = xx.checksum(payload, 0);
    }

    const end = timer.read();

    const mb_size = 1000000;
    var mb_processed: f64 = f64((iteration_count * payload.len))/ mb_size;

    const elapsed_s = f64(end - start) / time.ns_per_s;

    // need to make sure results are not optimized away
    warn("\nresult: {x}", results[0]);
    return mb_processed/elapsed_s;
}

fn average(n: usize, load_size: usize) !f64 {
    var i: usize = 0;
    var avg: f64 = 0;
    var prng = rand.DefaultPrng.init(0);
    var buf = try std.heap.c_allocator.alloc(u8, load_size);
    while (i < n): (i += 1) { 
        prng.random.bytes(buf[0..]);
        avg += try bench(buf);
    }
    return avg / f64(n);
}


pub fn main() !void {
 
    var result8 = try average(20, 8);
    warn("\n\nMB/s:   {.3}\t\n", result8);

    var result64 = try average(20, 64);
    warn("\n\nMB/s:   {.3}\t\n", result64);

    var result128 = try average(20, 128);
    warn("\n\nMB/s:   {.3}\t\n", result128);

    var result4000 = try average(20, 4000);
    warn("\n\nMB/s:   {.3}\t\n", result4000);

}