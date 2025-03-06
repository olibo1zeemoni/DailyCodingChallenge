import Cocoa

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

let nums1 = [2, 4, 6, 2, 5]
let result1 = maxNonAdjacentSum(nums1)
print(result1)  // Output: 13

let nums2 = [5, 1, 1, 5]
let result2 = maxNonAdjacentSum(nums2)
print(result2)  // Output: 10
"""
 Iteration:
 For each element in the array:
 Calculate newExclude as the maximum of the current include and exclude (i.e., the maximum sum up to the previous element).
 Update include to be the sum of exclude (previous best without the current element) and the current element, but only if adding the current element is beneficial (i.e., nums[i] is non-negative).
 Set exclude to newExclude.
 Final Result: The result is the maximum of the final include and exclude, as this represents the best possible sum we can achieve either by including or excluding the last element.
 """
