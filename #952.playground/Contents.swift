import Cocoa

var greeting = "Hello, playground"

func originalDigits(_ s: String) -> String {
    var charCount = [Character: Int]()
    
    // Count the frequency of each character in the input string
    for char in s {
        charCount[char, default: 0] += 1
    }
    
    // Array to store the count of each digit
    var digitCount = [Int](repeating: 0, count: 10)
    
    // Identify each number based on unique characters
    digitCount[0] = charCount["z", default: 0] // "zero"
    digitCount[2] = charCount["w", default: 0] // "two"
    digitCount[4] = charCount["u", default: 0] // "four"
    digitCount[6] = charCount["x", default: 0] // "six"
    digitCount[8] = charCount["g", default: 0] // "eight"
    
    // Now identify other numbers using other remaining characters
    digitCount[3] = charCount["h", default: 0] - digitCount[8] // "three" (eight already used)
    digitCount[5] = charCount["f", default: 0] - digitCount[4] // "five" (four already used)
    digitCount[7] = charCount["v", default: 0] - digitCount[5] // "seven" (five already used)
    digitCount[1] = charCount["o", default: 0] - digitCount[0] - digitCount[2] - digitCount[4] // "one" (zero, two, and four already used)
    digitCount[9] = charCount["i", default: 0] - digitCount[5] - digitCount[6] - digitCount[8] // "nine" (five, six, and eight already used)
//    digitCount[9] = (charCount["n", default: 0] - digitCount[7])/2
    ///nine has two n's
    
    // Construct the final result string by repeating the digits based on their counts
    var result = ""
    for i in 0...9 {
        result += String(repeating: String(i), count: digitCount[i])
    }
    return result
}

// Example usage:
let input1 = "eninenseveihirtfneenve"
let input2 = "nithrrenefoeu"

print(originalDigits(input1)) // Should print "357"
print(originalDigits(input2))


var charCount = [Character: Int]()
charCount["z"] = 2
let value = charCount["z", default: 0]
print(value)
