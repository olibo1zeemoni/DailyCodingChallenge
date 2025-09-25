import Cocoa
import SwiftUI

func isNumber(_ s: String) -> Bool {
    let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Check if the string is empty after trimming
    if trimmed.isEmpty {
        return false
    }
    
    // Use NumberFormatter to attempt parsing the string as a number
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.allowsFloats = true
    formatter.decimalSeparator = "."
    
    // Check for standard decimal numbers (including negatives)
    if formatter.number(from: trimmed) != nil {
        return true
    }
    
    // Check for scientific notation
    let scientificPattern = "^[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?$"
    let scientificRegex = try? NSRegularExpression(pattern: scientificPattern, options: [])
    
    ///tells the regex to check the entire string, from the beginning (location 0) to the end (length of the string)
    if let _ = scientificRegex?.firstMatch(in: trimmed, options: [], range: NSRange(location: 0, length: trimmed.utf16.count)) {
        return true
    }
    
    return false
}

// Test cases
let testCases = ["10", "-10", "10.1", "-10.1", "1e5", "a", "x 1", "a -2", "-", "  3  ", ".5", "-.5", "1e-5", "+10", "+1.5"]

//for test in testCases {
//    print("\(test): \(isNumber(test))")
//}


