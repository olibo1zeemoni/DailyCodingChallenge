import UIKit

var greeting = "Hello, playground"

func transitiveClosure(graph: [[Int]]) -> [[Int]] {
    let n = graph.count
    var closure = Array(repeating: Array(repeating: 0, count: n), count: n)
    for i in 0..<n {
        for j in graph[i] {
            closure[i][j] = 1
        }
    }
    for k in 0..<n {
        for i in 0..<n {
            for j in 0..<n {
                closure[i][j] |= (closure[i][k] & closure[k][j])
            }
        }
    }
    return closure
}

var graph = [
    [0, 1, 3],
    [1, 2],
    [2],
    [3]
]

let newAns = transitiveClosure(graph: graph)
print(newAns)

/*
 The function takes a graph represented as an adjacency list, and returns the transitive closure as a matrix.

 The first loop initializes the closure matrix with the edges in the graph. The second loop applies the Floyd-Warshall algorithm by iterating over all possible pairs of vertices and checking if there is a path between them through the intermediate vertex k.

 Note that the Swift implementation uses the bitwise OR operator |= instead of the logical OR operator ||, as the former is more efficient for working with binary values.
 */
