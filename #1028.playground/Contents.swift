import Cocoa

// Function to convert string to ASCII decimal values
func asciiDecimalMapping(_ text: String) -> [Int] {
    return text.lowercased().map { Int(String($0).utf8.first!) }
}

// Function to convert decimal to binary
func decimalToBinary(_ decimal: Int) -> String {
    return String(decimal, radix: 2)
}

// Main function to process the string
func processString(_ text: String) {
    // Remove spaces for ASCII mapping
    let processedText = text.replacingOccurrences(of: " ", with: "")

    // Get ASCII decimal values
    let decimalValues = asciiDecimalMapping(processedText)

    // Convert to binary
    let binaryValues = decimalValues.map { decimalToBinary($0) }

    // Print results
    print("String: \(processedText)")
    print("\nASCII Decimal Mapping:")
    for (char, decimal) in zip(processedText, decimalValues) {
        print("\(char): \(decimal)")
    }

    print("\nBinary Representations:")
    for (char, binary) in zip(processedText, binaryValues) {
        print("\(char): \(binary)")
    }
}

//processString("tiananmen square")

let words = ["one", "two", "three", "four"]
let numbers = 1...5

for (word, number) in zip(words, numbers) {
    // print(word, number)
}

let promt = """
    The number 6174 is known as Kaprekar's contant, after the mathematician who discovered an associated property: for all four-digit numbers with at least two distinct digits, repeatedly applying a simple procedure eventually results in this value. The procedure is as follows:
                                                        
        For a given input x, create two new numbers that consist of the digits in x in ascending and descending order.

    Subtract the smaller number from the larger number.
    For example, this algorithm terminates in three steps when starting from 1234:
    4321 - 1234 = 3087
    8730 - 0378 = 8352
    8532 - 2358 = 6174
    Write a function that returns how many steps this will take for a given input N.
"""
func kaprekarSteps(_ N: Int) -> Int {
    // Kaprekar's constant
    let KAPREKAR_CONSTANT = 6174
    
    // Ensure the number is valid
    guard N >= 1000, N <= 9999, Set(String(N)).count >= 2 else {
        return 0 // Invalid input
    }
    
    var steps = 0
    var current = N
    
    while current != KAPREKAR_CONSTANT {
        // Convert the number to a string of digits
        let digits = String(format: "%04d", current).map { $0 }
        
        // Create the largest and smallest numbers from the digits
        let largest = Int(String(digits.sorted(by: >)))!
        let smallest = Int(String(digits.sorted(by: <)))!
        
        // Perform the subtraction
        current = largest - smallest
        steps += 1
    }
    
    return steps
}

// Example usage
let steps1 = kaprekarSteps(1234) // Output: 3
print("Steps to reach 6174 for 1234: \(steps1)")

let steps2 = kaprekarSteps(9831) // Output: 7
print("Steps to reach 6174 for 9831: \(steps2)")
print("Steps to reach 6174 for 0001: \(kaprekarSteps(1001))")
