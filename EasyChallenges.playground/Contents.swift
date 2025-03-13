import AppKit

prefix operator +++
infix operator +- : AdditionPrecedence

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

struct SquareGrid {
    let size: Int
    private var storage: [[Int]]

    init(size: Int) {
        self.size = size
        self.storage = Array(
            repeating: Array(repeating: 0, count: size), count: size)
    }

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

var grid4x4 = SquareGrid(size: 4)

grid4x4[3, 3] = 10
//print(grid4x4, separator: " ")

//in-out parameters

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 4, columns: 4)
matrix[3, 3] = 25
//print(matrix.grid)
enum Planet: Int {
    case mercury = 1
    case venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[3]
//print(String(reflecting: mars))
//print(type(of: mars))

extension Matrix {
    static func + (lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrices must have the same dimensions")
        var result = Matrix(rows: lhs.rows, columns: lhs.columns)
        for i in 0..<lhs.rows {
            for j in 0..<lhs.columns {
                result[i, j] = lhs[i, j] + rhs[i, j]
            }
        }
        return result
    }
}
extension Matrix {
    static prefix func +++ (matrix: inout Matrix) -> Matrix {
        return matrix + matrix
    }
}

@propertyWrapper
struct SomeWrapper {
    
    var wrappedValue: Int
    var someValue: Double
    init() {
        self.wrappedValue = 100
        self.someValue = 12.3
    }
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
        self.someValue = 45.6
    }
    init(wrappedValue value: Int, custom: Double) {
        self.wrappedValue = value
        self.someValue = custom
    }
}


struct SomeStruct {
    // Uses init()
    @SomeWrapper var a: Int


    // Uses init(wrappedValue:)
    @SomeWrapper var b = 10 {
        didSet {
            print("b accessed")
        }
    }


    // Both use init(wrappedValue:custom:)
    @SomeWrapper(custom: 98.7) var c = 30
    @SomeWrapper(wrappedValue: 30, custom: 98.7) var d

}


var someStructInstance = SomeStruct()
someStructInstance.a = 20
someStructInstance.b = 111
