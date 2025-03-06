import Cocoa

"""
You are given an array of length n + 1 whose elements belong to the set {1, 2, ..., n}. By the pigeonhole principle, there must be a duplicate. Find it in linear time and space
"""
func findDuplicate(_ nums: [Int]) -> Int {
    // Step 1: Initialize the tortoise and hare
    var tortoise = nums[0]
    var hare = nums[0]
    
    // Step 2: Phase 1 - Detect the cycle
    repeat {
        tortoise = nums[tortoise]
        hare = nums[nums[hare]]
    } while tortoise != hare
    
    // Step 3: Phase 2 - Find the entrance to the cycle
    tortoise = nums[0]
    while tortoise != hare {
        tortoise = nums[tortoise]
        hare = nums[hare]
    }
    
    // The duplicate number
    return hare
}

// Example usage:
let nums = [1, 3, 4, 2, 2, 5]
let duplicate = findDuplicate(nums)
print("Duplicate number is: \(duplicate)")  // Output: 2

func findDup(input: [Int]) -> Int? {
    var setInput = Set(input)
    
    for num in input {
        if !setInput.insert(num).inserted {
            return num
        }
    }
    return nil
}

findDuplicate(nums)
