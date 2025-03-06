import Cocoa

var greeting = "Hello, playground"
func towerOfHanoi(n: Int, fromRod: Int, toRod: Int, auxRod: Int) {
    // Base case: Only one disk to move
    if n == 1 {
        print("Move disk 1 from rod \(fromRod) to rod \(toRod)")
        return
    }
    
    // Move n-1 disks from the starting rod to the auxiliary rod
    towerOfHanoi(n: n - 1, fromRod: fromRod, toRod: auxRod, auxRod: toRod)
    
    // Move the nth(largest) disk to the destination rod
    print("Move disk \(n) from rod \(fromRod) to rod \(toRod)")
    
    // Move the n-1 disks from the auxiliary rod to the destination rod
    towerOfHanoi(n: n - 1, fromRod: auxRod, toRod: toRod, auxRod: fromRod)
    
}

// Example usage
let n = 3
towerOfHanoi(n: n, fromRod: 1, toRod: 3, auxRod: 2)

func towerOfHanoi(n: Int, from: Int, to: Int, aux: Int) {
    if n == 1 {
        print("Move disk 1 from rod \(from) to rod \(to)")
        return
    }
    
    towerOfHanoi(n: n - 1, from: from, to: aux, aux: to)
    print("Move disk \(n) from rod \(from) to rod \(to)")
    towerOfHanoi(n: n - 1, from: aux, to: to, aux: from)
}

// Function to start the Tower of Hanoi solution
func solveTowerOfHanoi(n: Int) {
    print("Steps to solve Tower of Hanoi with \(n) disks:")
    towerOfHanoi(n: n, from: 1, to: 3, aux: 2)
}

// Example usage
//solveTowerOfHanoi(n: 4)
