import Cocoa

"""
Write an algorithm that finds the total number of set bits in all integers between 1 and N
"""
///left bitwise  a<<b = a(b^2)
///right bitwise a>>b  = a/(2^b)
func countSetBits(_ N: Int) -> Int {
    var totalSetBits = 0
    var i = 0
    
    // Iterate through each bit position
    while (1 << i) <= N {
        // Calculate the size of the block of 1's and 0's for the current bit position
        let blockSize = 1 << (i + 1)
        
        // Find the number of full blocks of the current bit length
        let fullBlocks = N / blockSize
        
        // Each full block contributes 1's to half the block size
        totalSetBits += fullBlocks * (blockSize / 2)
        
        // Add the remaining 1's from the partial block (if any)
        let remainder = N % blockSize
        totalSetBits += max(0, remainder - (blockSize / 2) + 1)
        
        // Move to the next bit position
        i += 1
    }
    
    return totalSetBits
}

// Example usage:
let N = 2
print(countSetBits(N))  // Output: 12
print(2<<1)
"""


Miami Dolphins     23-24        Buffalo Bills
Baltimore Ravens           Las Vegas Raiders
Carolina Panthers          Los Angeles Chargers
Dallas Cowboys     34-20        New Orleans Saints
Detroit Lions      38-21        Tampa Bay Buccaneers
Green Bay Packers  10-17        Indianapolis Colts
Jacksonville Jaguars       Cleveland Browns
Minnesota Vikings          San Francisco 49ers
New England Patriots       Seattle Seahawks
Tennessee Titans           New York Jets
Washington Commanders      New York Giants
Arizona Cardinals          Los Angeles Rams
Denver Broncos             Pittsburgh Steelers
Kansas City Chiefs         Cincinnati Bengals
"""

"""
zirk
sun
once
LDU
"""
