import AppKit

var greeting = "Hello, playground"

func isPerfectSquare(num: Int) -> Bool {
    var root = Int(Double(num).squareRoot())
    return root * root == (num)
}

isPerfectSquare(num: 9)

func printFitzbitz(x: Int) {
    for i in 1...x {
        var f = i % 3
        var b = i % 5
        switch (f, b) {
        case (0, 0):
            print("fritzbitz")
        case (0, _):
            print("fitz")
        case (_, 0):
            print("bitz")
        default:
            break
        }
    }
}
//MARK: Defer
var i = 3
if i < 100 {
    i += 100
    defer {
        i -= 100
    }
    print("\(i)")
}
//print("\(i)")

var score = 0
if score < 10 {
    defer {
        //print("\(score)")
    }
    score += 5
}

//MARK: -Subscript
struct Timestable {
    var multiplier: Int
    subscript(index: Int) -> Int {
        get {
            return index * multiplier
        }

        set {
            multiplier = newValue / 3
        }
    }
}

var threeTimesTable = Timestable(multiplier: 3)
var threeTimeTwo = threeTimesTable[2]
//print(threeTimeTwo)

struct Grid {
    let size: Int
    private var storage: [[Int]]

    init(size: Int) {
        self.size = size
        self.storage = Array(
            repeating: Array(repeating: 0, count: size), count: size)
    }

//    private var grid: [[Int]] {
//        get {
//
//            return storage
//        }
//        set {
//            storage = newValue
//        }
//    }

    subscript(row: Int, col: Int) -> Int {
        get {
            return storage[row][col]
        }

        set {
            guard row >= 0, col >= 0, row < size, col < size else {
                fatalError("Range out of bounds")
            }
            storage[row][col] = newValue
        }

    }
}

var grid4x4 = Grid(size: 4)

grid4x4[3, 3] = 10
print(grid4x4[3, 3])

