//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
"""
Given a list of integers, write a function that returns the largest sum of non-adjacent numbers. Numbers can be 0 or negative.

For example, [2, 4, 6, 2, 5] should return 13, since we pick 2, 6, and 5. [5, 1, 1, 5] should return 10, since we pick 5 and 5.

Follow-up: Can you do this in O(N) time and constant space?

"""
func maxNonAdjacentSum(_ nums: [Int]) -> Int {
    // Edge cases: If the list is empty, return 0
    if nums.isEmpty { return 0 }
    if nums.count == 1 { return max(0, nums[0]) }
    
    // Initialize two variables to track the maximum sums
    var include = max(0, nums[0]) // Max sum including the current element
    var exclude = 0               // Max sum excluding the current element
    
    for i in 1..<nums.count {
        // Current max excluding the current element
        let newExclude = max(include, exclude)
        
        // Update include to be the sum of exclude and the current element
        include = exclude + max(0, nums[i])
        
        // Update exclude to the previously computed newExclude
        exclude = newExclude
    }
    
    // The result is the max of include and exclude at the end of the loop
    return max(include, exclude)
}

// Example usage:
let nums1 = [2, 4, 6, 2, 5]
let result1 = maxNonAdjacentSum(nums1)
print(result1)  // Output: 13

let nums2 = [5, 1, 1, 5]
let result2 = maxNonAdjacentSum(nums2)
print(result2)  // Output: 10
