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

//MARK: - Closure capturing in action
func makeIncrementer (startingFrom value: Int) -> () -> Int {
    var temp = value
    let inc: () -> Int = {
        temp += 1
        return temp
    }
    return inc
}

let incrementFrom5 = makeIncrementer(startingFrom: 5)
//print(incrementFrom5())
//print(incrementFrom5())

class Counter {
    var count: Int = 0
    
    func increment(){
        count += 1
    }
}

struct CounterStruct {
    var count: Int = 0
    
    mutating func increment(){
        count += 1
    }
}

let letters = ["a", "b", "c", "d"]

var a = 2

func mutate(x: inout Int) {
    x = x * 2
}

mutate(x: &a)

print(a)

struct State {
    struct InnerState {
        mutating  func touch() {
            print("InnerState.touch called")
            // No actual mutation to `self` (no property changed)
        }
    }

    var innerState: InnerState {
        didSet {
            print("didSet: innerState changed (or at least was set)")
        }
    }
}

var state = State(innerState: State.InnerState())
state.innerState.touch()

func adds(_ x: Int, _ y: Int) -> Int { x + y }

let ops: [(Int,Int) -> Int] = [adds, {$0 * $1}, {$0 - $1}]
ops[1](5, 3)

let numbers = [20,19,7,12]

numbers.map{$0 % 2 == 1 ? 0 : $0 * 3}
