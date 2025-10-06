import Foundation
import SwiftUI

struct UserProfile: Identifiable, Decodable, Sendable{
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
/*
func fetchUserData(for id: String) async throws {
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
    try await fetchUserData(for id: "user123")
}
*/

enum UserDataResults{
    case userProfile(UserProfile)
    case posts([Post])
}

func fetchUserDataWithTaskGroup(for userID: String) async throws {
    let start = Date.now
    
    var userProfile: UserProfile?
    var userPosts: [Post]?
    
    print("🚀 Setting up a task group.")
    
    try await withThrowingTaskGroup(of: UserDataResults.self) { group in
       
       group.addTask {
           let profile = try await fetchUser(using: userID)
           return .userProfile(profile)
       }
       
       group.addTask {
           let posts = try await fetchPosts(for: userID)
           return .posts(posts)
       }
       
       print("✅ All tasks added to the group, Now waiting for results...")
       
        for try await result in group {
            switch result {
            case .userProfile(let profile):
                userProfile = profile
                print("👤 Profile result received from group")
            case .posts(let posts):
                userPosts = posts
                print("📚 Posts result received from group")
            }
        }
    }
    print("\n🎉 Task group finished, All results collected.")
    
    if let userProfile, let userPosts {
        print("Final Profile Name: \(userProfile.username)")
        print("Final Posts Count: \(userPosts.count)")
    }
    
    let timeElapsed = Date.now.timeIntervalSince(start)
    print("\nTotal time to load all data \(String(format: "%0.2f", timeElapsed))")
}


//Task {
//    try await fetchUserDataWithTaskGroup(for: "user123")
//}

//MARK: fine-grained read-write lock.

final class UserProfileCache: @unchecked Sendable {
    private let queue = DispatchQueue(label: "com.example.UserProfileCache.queue", attributes: .concurrent)
    
     private var cache: [String: UserProfile] = [:]
    
    func setProfile(_ profile: UserProfile, userID: String) {
        queue.async(flags: .barrier) {
            self.cache[userID] = profile
            print("CACHE WRITE: Set profile for \(userID)")
        }
    }
    
    func getProfile(userID: String) -> UserProfile? {
        var userProfile: UserProfile?
        ///`sync` because we need to block until we get the value back in order to return it.
        queue.sync {
            userProfile = cache[userID]
        }
        print("CACHE READ: Got profile for \(userID)")
        return userProfile
    }
    
}

func listPhotos(inGallery: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(3))
    return [inGallery + "_Photo1", inGallery + "_Photo2", inGallery + "_Photo3"]
}

func downloadPhoto(name: String) async throws -> Data {
    try await Task.sleep(for: .seconds(1))
    return Data("\(name).jpg".utf8)
}

func downloadPhoto(_ name: String) async throws -> Image {
    try await Task.sleep(for: .seconds(1))
    let data = Data("\(name).jpg".utf8)
    
    let image = Image(uiImage: UIImage(data: data)!)
    return image
}

func downloadPhotos(inGallery: String) async throws -> [Data] {
    var results: [Data] = []
    try await withThrowingTaskGroup(of: Data.self) { group in
        let photoNames = try await listPhotos(inGallery: inGallery)
        for name in photoNames {
            group.addTask {
                return try await downloadPhoto(name: name)
            }
        }
        
        for try await photoData in group {
            results.append(photoData)
        }
        return results
        
    }
    return results
}

//each task is added using addTaskUnlessCancelled(:)
func downloadPhotosWithCancellation(inGallery: String) async throws -> [Data] {
    var results: [Data] = []
    try await withThrowingTaskGroup { group in
        let photoNames = try await listPhotos(inGallery: inGallery)
        for name in photoNames {
            let added = group.addTaskUnlessCancelled {
                Task.isCancelled ? nil : try await downloadPhoto(name: name)
            }
            guard added else { break }
        }
        
        for try await photo in group {
            if let photo {
                results.append(photo)
            }
        }
    }
    return results
}

Task {
    let results = try await downloadPhotos(inGallery: "Vacation")
    for photo in results {
        print(String(data: photo, encoding: .utf8)!)
    }
}


//MARK: Downloads a collection of images concurrently, with support for cancellation.
func downloadImagesConcurrently(urls: [URL]) async throws -> [UIImage] {
    var images: [UIImage] = []
    do {
        try await withThrowingTaskGroup(of: UIImage?.self) { group in
            for url in urls {
                group.addTask {
                    try Task.checkCancellation()
                    let (data,_) = try await URLSession.shared.data(from: url)
                    try Task.checkCancellation()
                    return UIImage(data: data)
                }
                
                for try await image in group {
                    if let image = image {
                        images.append(image)
                    }
                }
                
            }
        }
    } catch  {
        ///Cancellation error thrown from inside the group will be handled here.
        print("Task group was cancelled. Downloaded \(images.count) images before stopping.")
    }
    
    return images
}


/// Downloads a collection of images concurrently with robust cancellation.
func downloadAllImages(for urls: [URL]) async -> [UIImage] {
    var images: [UIImage] = []
    
    do {
        try await withThrowingTaskGroup(of: UIImage?.self) { group in
            for url in urls {
                guard group.addTaskUnlessCancelled(operation: {
                    try Task.checkCancellation()
                    let (data, _) = try await URLSession.shared.data(from: url)
                    return UIImage(data: data)
                }) else {
                    break
                }
            }
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
        }
    } catch {
        print("Task group was cancelled. Downloaded \(images.count) images before stopping.")
    }
    
    return images
}
