import Foundation

struct UserProfile: Identifiable, Decodable{
    var id: String
    var username: String
}

struct Post: Identifiable, Decodable {
    var id: String
    var title: String
}

func fetchUser(using id: String) async throws -> UserProfile {
    print("1. ⏳Starting to fetch profile...")
    try await Task.sleep(for: .seconds(2))
    print("5. ✅ Finished fetching user profile.")
    
    return UserProfile(id: id, username: "jane doe")
}

func fetchPosts(for id: String) async throws -> [Post] {
    print("2. ⏳Starting to fetch posts...")
    try await Task.sleep(for: .seconds(3))
    print("8. ✅ Finished fetching posts.")
    
    return [Post(id: id, title: "My old tweet")]
}

func fetchUserData(id: String) async throws {
    let start = Date.now
    
    async let user =  fetchUser(using: id)
    
    async let posts = fetchPosts(for: id)
    
    print("3. 🚀Both fetch operations are running simultaneously")
    
    print("4. About to await the user profile")
    let userProfile = try await user
    print("6. 👤 Profile received \(userProfile.username)")
    
    print("7. About to await the posts")
    let userPosts = try await posts
    print("9. Posts received: \(userPosts.count)")
    
    let timeElapsed = Date.now.timeIntervalSince(start)
    
    print("\n10. Fetch operation lasted \(String(format: "%.2f", timeElapsed)) seconds")
    
}

Task {
    try await fetchUserData(id: "user123")
}
