import Cocoa

var promt = """
        solve it using Swift
        Given a 32-bit integer, return the number with its bits reversed.
        For example, given the binary number 1111 0000 1111 0000 1111 0000 1111 0000, return 0000 1111 0000 1111 0000 1111 0000 1111.
    """

class Solution {
    func reverseBits(_ n: UInt32) -> UInt32 {
        // Use Swift's built-in bitwise operations and count of trailing zeros
        var result: UInt32 = 0
        for i in 0..<32 {
            result = (result << 1) | ((n >> i) & 1)
        }
        return result
    }
}

// Test the solution
let solution = Solution()
let input: UInt32 = 0b11110000111100001111000011110001
let reversed = solution.reverseBits(input)

print("Original: \(String(input, radix: 2))")
print("Reversed: \(String(reversed, radix: 2))")

//let reverseBits: (UInt32) -> UInt32 = { UInt32(String(repeating: "0", count: 32 - String($0, radix: 2).count) + String($0, radix: 2)).reducing(0) { ($0 << 1) | UInt32(String($1)) }
//}


