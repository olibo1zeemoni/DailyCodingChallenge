import Foundation

var greeting = """
    Given an array of numbers and a number k, determine if there are three entries in the array which add up to the specified number k. For example, given [20, 303, 3, 4, 25] and k = 49, return true as 20 + 4 + 25 = 49
    """

func threeSumExists(_ nums: [Int], target: Int) -> Bool {
    guard nums.count >= 3 else { return false }
    var sorted = nums.sorted()
    var n = nums.count

    for i in 0..<n - 2 {
        //check for duplicates
        if i > 0 && sorted[i] == sorted[i - 1] {
            continue
        }

        let needed = target - sorted[i]
        var left = i + 1
        var right = i - 1

        while left < right {
            let twoSum = sorted[left] + sorted[right]
            if twoSum == needed {
                return true
            } else if twoSum < needed {
                // Sum too small → move left pointer right to increase sum
                left += 1
            } else {
                // Sum too big   → move right pointer left to decrease sum
                right += 1
            }
        }

    }

    return false
}
