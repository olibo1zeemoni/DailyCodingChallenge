import Foundation

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
let nums = [1, 3, 4, 2, 2, 5, 3]
let duplicate = findDuplicate(nums)
//print("Duplicate number is: \(duplicate)")  // Output: 2

func findDup(input: [Int]) -> [Int] {
    var seen = Set<Int>()
    var duplicates = [Int]()
    
    for num in input {
        if seen.contains(num) {
            duplicates.append(num)
        }
        seen.insert(num)
    }
    return duplicates
}

//findDuplicate(nums)
//print(findDup(input: nums))

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var customersInLine2 = customersInLine

let removed =  { customersInLine.remove(at: 0) }
print(customersInLine)
print(customersInLine.count)

print("––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––")

func serve(customer: /*@autoclosure*/ ()->String) {
    print("Now serving \(customer())")
}

//serve(customer: removed)
//serve(customer: removed)
//serve(customer: removed)
//serve(customer: removed)
//serve(customer: removed)

func someFunc() -> Int {
    return 1
}

var someFunc1 = someFunc

func anotherFunc() -> (()->Int) {
    return someFunc
}

func add(a: Int, b: Int) -> Int {
    a + b
}

func operate(a: Int, b: Int, using op:((Int, Int) -> Int)) -> Int {
    op(a,b)
}


let result = operate(a: 1, b: 2, using: add)


func makeIncrement (startingFrom value: Int) -> () -> Int {
    var temp = value
    func inc () -> Int {
        temp += 1
        return temp
    }
    return inc
}

let incrementFrom5 = makeIncrement(startingFrom: 5)
print(incrementFrom5())
print(incrementFrom5())
