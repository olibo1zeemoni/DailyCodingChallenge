import Foundation

let prompt = """
Write a function in Swift, add_subtract, which alternately adds and subtracts curried arguments. Here are some sample operations: add_subtract(7) -> 7 add_subtract(1)(2)(3) -> 1 + 2 - 3 -> 0 add_subtract(-5)(10)(3)(9) -> -5 + 10 - 3 + 9 -> 11 
"""
//func add_subtract(_ initial: Int) -> ((Int) -> Any) {
//    var total = initial
//    var isAdd = false // Start with subtraction for the next operation
//
//    // Define a nested function to perform the next operation
//    func nextOperation(_ nextValue: Int) -> Any {
//        if isAdd {
//            total += nextValue
//        } else {
//            total -= nextValue
//        }
//        isAdd.toggle() // Toggle between addition and subtraction
//        return nextOperation // Return the next function to allow chaining
//    }
//
//    // Define a closure to get the total
//    let getTotal: () -> Int = { total }
//
//    // Create a new type to hold both the next operation and the total closure
//class OperationWrapper {
//    let next: (Int) -> Any
//    let getTotal: () -> Int
//
//    init(next: @escaping (Int) -> Any, getTotal: @escaping () -> Int) {
//        self.next = next
//        self.getTotal = getTotal
//    }
//}
//
//    // Return an instance of OperationWrapper
//    return { nextValue in
//        let next = nextOperation(nextValue)
//        return OperationWrapper(next: next as! (Int) -> Any, getTotal: getTotal)
//    }
//}

// Test cases
//if let result = add_subtract(7) as? OperationWrapper {
//    print(result.getTotal()) // Output: 7
//}
//
//if let result = (add_subtract(1)(2) as? OperationWrapper)?.next(3) as? OperationWrapper {
//    print(result.getTotal()) // Output: 0
//}
//
//if let result = ((add_subtract(-5)(10) as? OperationWrapper)?.next(3) as? OperationWrapper)?.next(9) as? OperationWrapper {
//    print(result.getTotal()) // Output: 11
//}

