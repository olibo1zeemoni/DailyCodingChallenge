import Foundation

func moveZeroes(_ nums: inout [Int]) {
    // First remove all zeros and count them
    var zeroCount = 0
    nums = nums.filter { num in
        if num == 0 {
            zeroCount += 1
            return false
        }
        return true
    }
    
    // Then append the zeros at the end
    nums.append(contentsOf: Array(repeating: 0, count: zeroCount))
}

var someArray = [0,9,5,2,3,0,0,4,0,7,0,0]
var anotherArray = [0,1,2,3,4,0]

//moveZeroes(&anotherArray)
moveZeroes(&someArray)
