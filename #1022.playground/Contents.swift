import Cocoa

var prompt = """
    Given an array of integers where every integer occurs three times except for one integer, which only occurs once, find and return the non-duplicated integer.

    For example, given [6, 1, 3, 3, 3, 6, 6], return 1. Given [13, 19, 13, 13], return 19.

    Do this in O(N) time and O(1) space.
"""

func singleNumber(_ nums: [Int]) -> Int {
    var ones = 0     // Tracks bits that have appeared once
    var twos = 0     // Tracks bits that have appeared twice

    for num in nums {
        // Update 'twos' to include bits that are in 'ones' and 'num'
        twos |= ones & num
        
        // Update 'ones' to include the current number's bits
        ones ^= num
        
        // Mask to remove bits that appear three times
        let threes = ones & twos
        ones &= ~threes
        twos &= ~threes
    }
    
    return ones
}

// Example usage
let nums1 = [6, 1, 3, 3, 3, 6, 6]
print(singleNumber(nums1)) // Output: 1

let nums2 = [13, 19, 13, 13]
print(singleNumber(nums2)) // Output: 19

