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
        precondition(
            lhs.rows == rhs.rows && lhs.columns == rhs.columns,
            "Matrices must have the same dimensions")
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
struct Capitalized {
    private var value: String = ""

    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

struct User {
    @Capitalized var name: String
}

var user = User(name: "john doe")
print(user.name)

let someArray = [10, 17, 80, 100, 124]

func customSearch(array: [Int], searchItem: Int) -> Int? {
    for item in array {
        if item == searchItem {
            return item
        } else if item > searchItem {
            break
        }

    }
    return nil
}

customSearch(array: someArray, searchItem: 81)

func binarySearch(array: [Int], searchTerm: Int) -> Int? {
    guard !array.isEmpty else {
        return nil
    }
    var lowerBound = 0
    var upperBound = array.count - 1

    while lowerBound <= upperBound {

        var midPoint = (lowerBound + upperBound) / 2
        //        print("midPoint = \(midPoint)")

        if searchTerm == array[midPoint] {
            return array[midPoint]
        } else if searchTerm > array[midPoint] {
            lowerBound = midPoint + 1
        } else if searchTerm < array[midPoint] {
            upperBound = midPoint - 1
        }
    }
    print("not found")
    return nil
}

let orderedArray = [1, 4, 7, 8, 10, 15, 17]
var item = binarySearch(array: orderedArray, searchTerm: 7)
//print("\(String(describing: item))")

func bubbleSort(array: [Int]) -> [Int] {
    var array = array
    var sorted = false
    var unsortedUntilIndex = array.count - 1

    while !sorted {
        sorted = true
        for i in 0..<unsortedUntilIndex {
            if array[i] > array[i + 1] {
                sorted = false
                array.swapAt(i + 1, i)
                unsortedUntilIndex - 1
            }
        }
    }
    return array
}

var anotherArray = [2, 5, 34, 23, 12, 16, 93, 45]
bubbleSort(array: anotherArray)

func hasDuplicate(array: [Int]) -> Bool {
    var steps = 0
    var existingArray = [Int: Bool]()
    for i in 0..<array.count {
        steps += 1
        let number = array[i]
        if existingArray[number] == nil {
            existingArray[number] = true
        } else {
            return true
        }
    }
    return false
}

hasDuplicate(array: anotherArray)

func selectionSort(array: [Int]) -> [Int] {
    var array = array
    for i in 0..<array.count {
        var lowestNumberIndex = i
        for j in i + 1..<array.count {
            if array[j] < array[lowestNumberIndex] {
                lowestNumberIndex = j //comparison
            }
        }
        if lowestNumberIndex != i {
            array.swapAt(i, lowestNumberIndex)
        }
    }

    return array
}

selectionSort(array: anotherArray)

func evenIndexArray(array: Array<AnyHashable>) -> [AnyHashable] {
//    var newArray  = [AnyHashable]()
//    for i in 0..<array.count {
//         i % 2 == 0 ?
//        newArray.append(array[i]):
//        ()
//        
//    }
//    return newArray
    array.enumerated().filter{ $0.offset % 2 == 0 }.map{ $0.element }
}

evenIndexArray(array: anotherArray)

func insertSort(array: inout [Int]) -> [Int] {
    for index in 1..<array.count {
        var position = index
        var tempValue = array[index]
        
        while position > 0 && array[position - 1] > tempValue {
            array[position] = array[position - 1]
            position -= 1
            array[position] = tempValue
//            array.swapAt(position, position - 1)
//            position -= 1
        }
    }
    return array
}
var newArray = [2, 5, 34, 23, 12, 16, 93, 45]
insertSort(array: &newArray)

func interSection(a: [Int], b:[Int]) -> [Int] {
//    var array = [Int]()
//    for i in a {
//        for j in b {
//            if i == j {
//                array.append(i)
//            }
//        }
//    }
//    return array
    a.filter{ element in b.contains(element)}
}

var a = [1,2,5,6,7]
var b = [5,6,9,10]
interSection(a: a, b: b)
