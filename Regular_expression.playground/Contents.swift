import Cocoa
import Foundation

let regex = "^[+-]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?$"
let numberPattern = try! NSRegularExpression(pattern: regex)

// Test function
func isValidScientificNumber(_ input: String) -> Bool {
    let range = NSRange(location: 0, length: input.utf16.count)
    return numberPattern.firstMatch(in: input, options: [], range: range) != nil
}

// Examples
print(isValidScientificNumber("123.45"))  // true
print(isValidScientificNumber("-123.45"))  // true
print(isValidScientificNumber("1.23e10"))  // true
print(isValidScientificNumber("-1.23E-10"))  // true
print(isValidScientificNumber("abc"))  // false
