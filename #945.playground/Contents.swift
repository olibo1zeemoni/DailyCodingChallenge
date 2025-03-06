import Cocoa

"""
This problem was asked by Uber.
Given a tree where each edge has a weight, compute the length of the longest path in the tree.
For example, given the following tree:
a
  /|\
 b c d
    / \
   e   f
  / \
 g   h
and the weights: a-b: 3, a-c: 5, a-d: 8, d-e: 2, d-f: 4, e-g: 1, e-h: 1, the longest path would be c -> a -> d -> f, with a length of 17.
The path does not have to pass through the root, and each node can have any amount of children.
"""

class TreeNode {
    let value: String
    var children: [(TreeNode, Int)] = []
    
    init(_ value: String) {
        self.value = value
    }
    
    func addChild(_ child: TreeNode, weight: Int) {
        children.append((child, weight))
    }
}

func longestPath(_ root: TreeNode) -> Int {
    func dfs(_ node: TreeNode) -> (Int, Int) {
        var maxPath = 0
        var firstMax = 0
        var secondMax = 0
        
        for (child, weight) in node.children {
            let (childMaxPath, childHeight) = dfs(child)
            maxPath = max(maxPath, childMaxPath)
            
            let totalHeight = childHeight + weight
            if totalHeight > firstMax {
                secondMax = firstMax
                firstMax = totalHeight
            } else if totalHeight > secondMax {
                secondMax = totalHeight
            }
        }
        
        maxPath = max(maxPath, firstMax + secondMax)
        return (maxPath, firstMax)
    }
    
    return dfs(root).0
}

// Create the tree
let a = TreeNode("a")
let b = TreeNode("b")
let c = TreeNode("c")
let d = TreeNode("d")
let e = TreeNode("e")
let f = TreeNode("f")
let g = TreeNode("g")
let h = TreeNode("h")

a.addChild(b, weight: 3)
a.addChild(c, weight: 5)
a.addChild(d, weight: 8)
d.addChild(e, weight: 2)
d.addChild(f, weight: 4)
e.addChild(g, weight: 1)
e.addChild(h, weight: 1)

// Find the longest path
let result = longestPath(a)
print("The length of the longest path is: \(result)")
