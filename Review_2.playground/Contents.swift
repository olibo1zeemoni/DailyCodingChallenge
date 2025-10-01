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
        
        print("last")
    }
    
    Task {
        try? await Task.sleep(for: .microseconds(0.000000000000003))
        print("finished sleeping")
    }
    
    print("begin")
}

Task {
    await somePrintFunc()
}

print("hello world")
