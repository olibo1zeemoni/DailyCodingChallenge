import SwiftUI
import UIKit
import PlaygroundSupport

struct ContentView: View {
    @State private var isTaskRunning = false
    
    var body: some View {
        List(1...50, id: \.self) {index in
            Text("\(index)")
        }
        VStack {
            Text(isTaskRunning ? "Long Task is running..." : "Long task is done")
            
            Button("Start long task"){
                isTaskRunning = true
                Task {
                    try! await Task.sleep(for: .seconds(5))
                    isTaskRunning = false
                }
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func doHeavyStuff() async {
//MARK:        old worker
//        let queue = DispatchQueue(label: "com.example.UserProfileCache.queue", attributes: .concurrent)
//        queue.async(flags: .assignCurrentContext) {
//            sleep(5)
//            DispatchQueue.main.async {
//                
//                isTaskRunning = false
//            }
//        }
    }
}


let host = UIHostingController(rootView: ContentView())
host.view.frame = CGRect(x: 0, y: 0, width: 300, height: 500)

//PlaygroundPage.current.liveView = host

func somePrintFunc() async {
    defer {
        
        print("last 1")
        print("last 2")
    }
    
    defer {
        print("last a")
        print("last b")
    }
    
    Task {
        try? await Task.sleep(for: .microseconds(0.000000000000003))
        print("finished sleeping")
    }
    
    print("begin")
    
    
    defer {
        print("last defer block")
    }
}

//let someTask = Task {
//    await somePrintFunc()
//}

//Task{
//    print(await someTask.result)
//}


func calculate(a: Int, b: Int) -> Int {
    return a + b
}

var result = calculate(a: 1, b: 2)

enum OptionalValue<Value> {
    case some(Value)
    case none
}

var someOptional: OptionalValue<Int> = .none
someOptional = .some(10)
someOptional
//MARK: print associated type of enum.
if case let .some(value) = someOptional {
    print(value)
}


func anyCommonElements<T:Sequence, U:Sequence> (_ aCollection: T, _ bCollection: U) -> Bool where  T.Element == U.Element, T.Element: Equatable  {
    for a in aCollection {
        if bCollection.contains(a) {
            return true
        }
    }
    return false
}

anyCommonElements([1,2], [1])

//print(1.25e2)
let a: UInt8 = 10
let b: UInt16 = 20
let c = b + UInt16(a)
//print(UInt8.max)
//print(Int8.max)
//print(sqrt(9))
print(String(reflecting: someOptional))

enum SandwichError: Error {
    case noUtensils
    case tooLittleBread
    case unforeseenError(String)
}

func makeSandwich() throws (SandwichError) -> String {
    return "a sandwich"
}

do {
    let result = try makeSandwich()
    print(result)
} catch .noUtensils{
    print("there are no utensils")
} catch .tooLittleBread{
    print("little to no bread")
} catch .unforeseenError(let unforeseenError) {
    print("some unforeseen error happened")
}
let bin = 0b11111
let hex = 0xAD
let oct = 0o26
//MARK: base 10 to 16, 8, 2
let toBase2 = String(173, radix: 2, uppercase: true)
let toBase8 = String(173, radix: 8, uppercase: true)
let toBase16 = String(173, radix: 16, uppercase: true)
//print(toBase16)
//print(toBase8)
//print(toBase2)

let base2toDecimal = Int("\(bin)", radix: 10)
let base8toDecimal = Int("\(oct)", radix: 10)
let base16toDecimal = Int("\(hex)", radix: 10)
//print(base2toDecimal!)
//print(base8toDecimal!)
//print(base16toDecimal!)


let someRange = ...5
let anotherRange = 5...

//print(someRange.contains(4)) //true
//print(anotherRange.contains(4)) //false

//for i in anotherRange {
//    guard i < 11 else { break }
//    print(i)
//    
//}

