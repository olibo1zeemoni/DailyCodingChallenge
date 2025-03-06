
func createPlaylist(lists: [[Int]]) -> Set<Int> {
  // Create a priority queue to hold all the songs
  var pq = [Int]()
  for lst in lists {
    for song in lst {
      pq.append(song)
    }
  }
  
  // Sort the priority queue in ascending order
  pq.sort()
  
  // Create the playlist by adding the songs from the priority queue in the order of their priorities
    var playlist = [Int]()
  for song in pq {
    playlist.append(song)
  }
  let set = Set(playlist)
  return set
}

// Test the function
let lists = [[1, 7, 3], [2, 1, 6, 7, 9], [3, 9, 5]]
print(createPlaylist(lists: lists))  // Should print [2, 1, 6, 7, 3, 9, 5]

