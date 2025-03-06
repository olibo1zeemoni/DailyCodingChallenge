import Cocoa
"""
This problem was asked by Twitter.

Implement an autocomplete system. That is, given a query string s and a set of all possible query strings, return all strings in the set that have s as a prefix.

For example, given the query string de and the set of strings [dog, deer, deal], return [deer, deal].

Hint: Try preprocessing the dictionary into a more efficient data structure to speed up queries.
"""

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord: Bool = false
}

class Trie {
    private let root: TrieNode
    
    init() {
        root = TrieNode()
    }
    
    func insert(_ word: String) {
        var current = root
        for char in word {
            if current.children[char] == nil {
                current.children[char] = TrieNode()
            }
            current = current.children[char]!
        }
        current.isEndOfWord = true
    }
    
    func autocomplete(_ prefix: String) -> [String] {
        var current = root
        for char in prefix {
            if let node = current.children[char] {
                current = node
            } else {
                return []
            }
        }
        return collectWords(node: current, prefix: prefix)
    }
    
    private func collectWords(node: TrieNode, prefix: String) -> [String] {
        var results: [String] = []
        if node.isEndOfWord {
            results.append(prefix)
        }
        
        for (char, childNode) in node.children {
            results += collectWords(node: childNode, prefix: prefix + String(char))
        }
        
        return results
    }
}

func autocompleteSystem(_ dictionary: [String], _ query: String) -> [String] {
    let trie = Trie()
    for word in dictionary {
        trie.insert(word)
    }
    return trie.autocomplete(query)
}

// Example usage
let dictionary = ["dog", "deer", "deal"]
let query = "de"
let result = autocompleteSystem(dictionary, query)
print(result)  // Output: ["deer", "deal"]


func filterDictionary(dictionary: [String], string: String) -> [String] {
    
    return dictionary.filter { $0.hasPrefix(string) }.sorted()
    
}

print(filterDictionary(dictionary: dictionary, string: "de"))
