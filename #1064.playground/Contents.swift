import Foundation

var prompt = "Using a function rand5() that returns an integer from 1 to 5 (inclusive) with uniform probability, implement a function rand7() that returns an integer from 1 to 7 (inclusive)."

func rand(input: Int) -> Int {
    var range = 1...input
    let someRand = range.randomElement()
    return someRand ?? 0
}

func rand5() -> Int {
    rand(input: 5)
}
    
func rand7() -> Int {
    Array(arrayLiteral: rand5(),6,7).randomElement() ?? 0
}

for _ in 1...7 {
    print(rand7())
}
