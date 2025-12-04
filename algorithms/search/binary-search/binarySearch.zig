const std = @import("std");

/// Binary search implementation.
/// Returns the index of the element if found, or null if not found.
/// Assumes the array is sorted in ascending order.
pub fn binarySearch(comptime T: type, sortedArray: []const T, seekElement: T) ?usize {
    var startIndex: usize = 0;
    var endIndex: usize = sortedArray.len;

    while (startIndex < endIndex) {
        const middleIndex = startIndex + (endIndex - startIndex) / 2;
        const value = sortedArray[middleIndex];

        if (value == seekElement) {
            return middleIndex;
        }

        if (value < seekElement) {
            startIndex = middleIndex + 1;
        } else {
            endIndex = middleIndex;
        }
    }

    return null;
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
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const nums = try generateSortedRandomArray(allocator, 10);
    std.debug.print("Sorted numbers: {any}\n", .{nums});

    // Pick a random element to search for
    const target = nums[std.crypto.random.uintLessThan(usize, nums.len)];
    
    if (binarySearch(u32, nums, target)) |index| {
        std.debug.print("Found {} at index {}\n", .{target, index});
    } else {
        std.debug.print("Did not find {}\n", .{target});
    }

    // Test not found
    const notFoundTarget = 99999999; 
    if (binarySearch(u32, nums, notFoundTarget)) |index| {
         std.debug.print("Found {} at index {}\n", .{notFoundTarget, index});
    } else {
         std.debug.print("Did not find {} (as expected, mostly)\n", .{notFoundTarget});
    }
}