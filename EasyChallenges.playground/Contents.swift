import UIKit

var greeting = "Hello, playground"

func isPerfectSquare(num: Int) -> Bool {
    var root = Int(Double(num).squareRoot())
    return root*root == (num)
}


isPerfectSquare(num: 9)

func printFitzbitz(x: Int) {
    for i in 1...x {
        var f = i % 3, b = i % 5
        switch (f,b) {
        case(0,0):
            print("fritzbitz")
        case (0, _) :
            print("fitz")
        case(_,0) :
            print("bitz")
        default:
            break 
        }
    }
}
//var x = 100
//var y = x % 3
//print("\(y)")
printFitzbitz(x: 100)
