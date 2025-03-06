import Foundation

var prompt = """
    Given two strings A and B, return whether or not A can be shifted some number of times to get B.

    For example, if A is abcde and B is cdeab, return true. If A is abc and B is acb, return false.
"""

func canShift(_ A: String, to B: String) -> Bool {
    // If the lengths are different, B cannot be a rotation of A
    guard A.count == B.count else {
        return false
    }
    
    // Concatenate A with itself and check if B is a substring
    let concatenated = A + A
    return concatenated.contains(B)
}

// Example usage:
let A = "abcde"
let B = "cdeab"

let result = canShift(A, to: B)
print(result) // Output: true
