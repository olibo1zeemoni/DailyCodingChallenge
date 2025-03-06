import UIKit

var greeting = "Hello, playground"

func findTwoSingleElements(in nums: [Int]) -> (Int, Int) {
    // Compute XOR of all elements in the array
    var xorAll = 0
    for num in nums {
        xorAll ^= num
    }
    // Find the position of the rightmost set bit in xorAll
    let rightmostSetBit = xorAll & ~(xorAll - 1)
    // Divide the numbers in nums into two groups:
    // - those that have the rightmost set bit set
    // - those that don't have it set
    var group1 = 0
    var group2 = 0
    for num in nums {
        if num & rightmostSetBit != 0 {
            group1 ^= num
        } else {
            group2 ^= num
        }
    }
    // Return the two single elements
    return (group1, group2)
}
var someArray = [2, 4, 6, 8, 10, 2, 6, 10]
let ans = findTwoSingleElements(in: someArray)
print(ans)

/*
 The idea of the solution is to use the fact that XOR of two equal numbers is zero, and that XOR is commutative and associative. Therefore, if we XOR all the numbers in the array, the result will be the XOR of the two single elements. We can then find a bit position where the two single elements differ (i.e., the XOR has a set bit), and use it to divide the numbers into two groups. The two single elements will end up in different groups, and we can XOR the elements in each group separately to obtain the two single elements. The time complexity of the solution is O(n), where n is the length of the array.
 */
