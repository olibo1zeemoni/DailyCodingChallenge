//: [Previous](@previous)

import Foundation

func fetchID(for server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

func fetchUser(for server: String) async -> String {
    let id = await fetchID(for: server)
    if id == 501 {
        return "john appleseed"
    }
    return "guest"
}

func connectUser(using server: String) async {
    async let id = fetchID(for: server)
    async let user = fetchUser(for: server)
    
    let greeting = await "Hello \(user), user ID: \(id)"
    print(greeting)
}

//Task {
//   await connectUser(using: "primary")
//}
enum ServerResponse {
    case userId(Int)
    case userName(String)
}

func fetchServerDataWithTaskGroup(using server: String) async {
    var userIds: [Int] = []
    var userNames: [String] = []
    
    let _ = await withTaskGroup(of: ServerResponse.self) { group in
        for server in ["primary","secondary","tertiary"] {
            group.addTask {
                let id = await fetchID(for: server)
                return .userId(id)
            }
            
            group.addTask {
                let user = await fetchUser(for: server)
                return .userName(user)
            }
        }
        
        for await result in group {
            switch result {
            case let .userId(id):
                userIds.append(id)
            case let .userName(name):
                userNames.append(name)
            }
        }
    }
    for id in userIds {
        print(id)
    }
    
    for userName in userNames {
        print(userName)
    }
    
}

Task {
    await fetchServerDataWithTaskGroup(using: "primary")
}
