const std = @import("std");

pub fn binarySearch(sortedArray: []u32, seekElement: u32) !u32 {
    var n = sortedArray.len;
    var i: usize = 0;

    while (i < n) {
        const middle = i + (n - i) / 2;
        if (sortedArray[middle] == seekElement) {
            return @intCast(middle);
        }

        if (sortedArray[middle] < seekElement) {
            i = middle + 1;
        } else {
            n = middle;
        }
    }
    return error.notFound;
}

pub fn generateSortedRandomArray(allocator: std.mem.Allocator, count: usize) ![]u32 {
    const arr = try allocator.alloc(u32, count);
    const rng = std.crypto.random;
    for (arr) |*a| {
        a.* = rng.int(u32);
    }

    std.sort.block(u32, arr, {}, std.sort.asc(u32));
    return arr;
}

pub fn main() !void {
    //const stdout = std.io.getStdOut().writer();
    var stdout = std.fs.File.stdout().writer(&.{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const nums = try generateSortedRandomArray(allocator, 10);
    try stdout.interface.print("Sorted numbers: {any}\n", .{nums});
    const result = binarySearch(nums, nums[std.crypto.random.uintLessThan(usize, nums.len)]);
    try stdout.interface.print("Found {any}\n ", .{result});
    std.debug.assert(result != error.notFound);
}
