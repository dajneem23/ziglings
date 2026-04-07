const std = @import("std");

pub fn genRandomNums(allocator: std.mem.Allocator, count: usize) ![]u32 {
    const arr = try allocator.alloc(u32, count);
    const rng = std.crypto.random;

    for (arr) |*a| {
        a.* = rng.int(u32);
    }

    return arr;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    arena.deinit();
    const allocator = arena.allocator();
    const nums = genRandomNums(allocator, 20);
    std.debug.print("random nums  {any}\n", .{nums});
}
