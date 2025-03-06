//import UIKit
// The requirement is to write a function that accepts an array as a parameter,
// and returns an array of the same length and same values, but
// the order of every other set of 4 integers from the original array should be reversed
// in the output array.

// Example input array:
// [7, 17, 28, 999,   1, 3, 2, 88,   65, 56, 3, 4]
//
// Required output array:
// [7, 17, 28, 999,   88, 2, 3, 1,   65, 56, 3, 4]

//func reverseEveryOtherSetOf4(arr: [Int]) -> [Int] {
//    var result: [Int] = []
//    for i in 0..<arr.count {
//        if i % 8 < 4 {
//            result.append(arr[i])
//        } else {
//            result.insert(arr[i], at: result.count - 3)
//        }
//    }
//    return result
//}

func reverseEveryOtherSetOf4(arr: [Int]) -> [Int] {
    var result: [Int] = []
    for i in 0..<arr.count {
        if i % 8 < 4 {
            result.append(arr[i])
        } else {
            result.insert(arr[i], at: result.count)
        }
    }
    return result
}

/*


 This function takes an array of integers as a parameter and returns a new array with the order of every other set of 4 integers reversed. It does this by looping through the input array and appending or inserting each element into the result array based on its position within the input array. If the index of an element is less than 4 modulo 8 (i.e., the first, second, third, or fourth element of every other set of 4), it is appended to the end of the result array. If the index is greater than or equal to 4 modulo 8 (i.e., the fifth, sixth, seventh, or eighth element of every other set of 4), it is inserted at the end of the result array. This effectively reverses the order of every other set of 4 integers in the input array.







 */

var arr = [7, 17, 28, 999,   1, 3, 2, 88,   65, 56, 3, 4]
reverseEveryOtherSetOf4(arr: arr)
