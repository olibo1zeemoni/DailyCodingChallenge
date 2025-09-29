import Foundation

var greeting = "Hello, playground"
print(greeting)

class UnsafeScoreKeeper {
    var score: Int = 0
    
    func increment(){
        score += 1
    }
}

actor SafeScoreKeeper {
    var score: Int = 0
    
    func increment(){
        score += 1
    }
}


func runUnsafeRace() async {
    let scoreKeeper = UnsafeScoreKeeper()
    
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<1000 {
            group.addTask {
                scoreKeeper.increment()
            }
        }
    }
    
    print("\(scoreKeeper.score) uns")
}

//Task {
//    await  runUnsafeRace()
//    await  runUnsafeRace()
//    await  runUnsafeRace()
//    await  runUnsafeRace()
//    await  runUnsafeRace()
//}


func runSafeRace() async {
    let scoreKeeper = SafeScoreKeeper()
    
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<1000 {
            group.addTask {
                await scoreKeeper.increment()
            }
        }
    }
    print(await scoreKeeper.score)
}

//Task {
//    await runSafeRace()
//    await runSafeRace()
//    await runSafeRace()
//    await runSafeRace()
//    await runSafeRace()
//}

