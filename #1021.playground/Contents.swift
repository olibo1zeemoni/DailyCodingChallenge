import Cocoa

var prompt = """
Given an unsigned 8-bit integer, swap its even and odd bits. The 1st and 2nd bit should be swapped, the 3rd and 4th bit should be swapped, and so on.

For example, 10101010 should be 01010101. 11100010 should be 11010001.

Bonus: Can you do this in one line?
"""
///The even bits can be masked with 0xAA (binary 10101010) and right shifted to move them to odd positions.
///The odd bits can be masked with 0x55 (binary 01010101) and left shifted to move them to even positions.

func swapEvenOddBits(_ x: UInt8) -> UInt8 {
    return ((x & 0xAA) >> 1) | ((x & 0x55) << 1)
}

let number1: UInt8 = 0b10101010
let result = swapEvenOddBits(number1)
String(result, radix: 2)
