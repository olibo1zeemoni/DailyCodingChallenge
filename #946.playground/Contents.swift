import Cocoa

var greeting = "Hello, playground"
func getRow(_ rowIndex: Int) -> [Int] {
    var row = [Int](repeating: 0, count: rowIndex + 1)
    row[0] = 1
    
    for i in 1...rowIndex {
        print("i is \(i)")
        for j in stride(from: i, through: 1, by: -1) {
            print("row[\(j)] is \(row[j])")
            row[j] += row[j - 1]
            print("row[\(j)] is \(row[j])")
            print("---end iteration---")
        }
    }
    
    return row
}


getRow(2)
