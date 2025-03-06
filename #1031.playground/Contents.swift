import Foundation
//import UIKit

var prompt = """
    Snakes and Ladders is a game played on a 10 x 10 board, the goal of which is get from square 1 to square 100. On each turn players will roll a six-sided die and move forward a number of spaces equal to the result. If they land on a square that represents a snake or ladder, they will be transported ahead or behind, respectively, to a new square.

        Find the smallest number of turns it takes to play snakes and ladders.

        For convenience, here are the squares representing snakes and ladders, and their outcomes:

        snakes = {16: 6, 48: 26, 49: 11, 56: 53, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 98: 78}
        ladders = {1: 38, 4: 14, 9: 31, 21: 42, 28: 84, 36: 44, 51: 67, 71: 91, 80: 100}
    """
struct Solution {
    // Define the game board elements
    let snakes: [Int: Int] = [
        16: 6, 48: 26, 49: 11, 56: 53, 62: 19,
        64: 60, 87: 24, 93: 73, 95: 75, 98: 78
    ]
    
    let ladders: [Int: Int] = [
        1: 38, 4: 14, 9: 31, 21: 42, 28: 84,
        36: 44, 51: 67, 71: 91, 80: 100
    ]
    
    func findShortestPath() -> Int {
        // Queue to store positions and moves taken
        // Each element is (position, moves)
        var queue: [(Int, Int)] = [(1, 0)]
        // Keep track of visited positions
        var visited = Set<Int>()
        visited.insert(1)
        
        while !queue.isEmpty {
            let (currentPos, moves) = queue.removeFirst()
            
            // Try all possible dice rolls (1-6)
            for roll in 1...6 {
                var nextPos = currentPos + roll
                
                // Check if we've reached or passed the goal
                if nextPos == 100 {
                    return moves + 1
                }
                if nextPos > 100 {
                    continue
                }
                
                // Check if we landed on a snake or ladder
                if let snakeEnd = snakes[nextPos] {
                    nextPos = snakeEnd
                } else if let ladderEnd = ladders[nextPos] {
                    nextPos = ladderEnd
                }
                
                // Add unvisited positions to queue
                if !visited.contains(nextPos) {
                    visited.insert(nextPos)
                    queue.append((nextPos, moves + 1))
                }
            }
        }
        
        return -1  // If no solution is found
    }
    
    // Helper function to print the path (optional)
    func printPath() {
        var queue: [(Int, Int, [Int])] = [(1, 0, [1])]
        var visited = Set<Int>()
        visited.insert(1)
        
        while !queue.isEmpty {
            let (currentPos, moves, path) = queue.removeFirst()
            
            for roll in 1...6 {
                var nextPos = currentPos + roll
                
                if nextPos == 100 {
                    print("Shortest path found in \(moves + 1) moves:")
                    print("Path: \(path + [nextPos])")
                    return
                }
                if nextPos > 100 {
                    continue
                }
                
                var newPath = path
                newPath.append(nextPos)
                
                if let snakeEnd = snakes[nextPos] {
                    nextPos = snakeEnd
                    newPath.append(nextPos)
                } else if let ladderEnd = ladders[nextPos] {
                    nextPos = ladderEnd
                    newPath.append(nextPos)
                }
                
                if !visited.contains(nextPos) {
                    visited.insert(nextPos)
                    queue.append((nextPos, moves + 1, newPath))
                }
            }
        }
        
        print("No solution found")
    }
}

// Test the solution
let game = Solution()
let shortestMoves = game.findShortestPath()
print("Minimum number of moves required: \(shortestMoves)")
game.printPath()
