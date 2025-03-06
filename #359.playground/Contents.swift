//import UIKit
import Foundation
import UIKit

var greeting = "threetwoone"

func isPossible(word: String)-> Bool{
    var rootWord = ""
    var tempWord = rootWord
    
    for letter in word {
        if let pos = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: pos)
        } else {
            return false
        }
    }
    return true
}

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledWord = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledWord.location == NSNotFound
}

func generateWords(from characters: [Character]) -> [String] {
    var words: [String] = []

    func generateWords(from characters: [Character], word: String) {
        if characters.isEmpty {
            // If the character array is empty, we have reached the end of the recursion
            // and we can append the current word to the array of words.
            words.append(word)
            return
        }

        // Include the current character in the word.
        generateWords(from: Array(characters.dropFirst()), word: word + String(characters[0]))

        // Skip the current character.
        generateWords(from: Array(characters.dropFirst()), word: word)
    }

    generateWords(from: characters, word: "")
    return words
}

let characters = Array("abc")
let words = generateWords(from: characters)
//print(words)  // Output: ["a", "ab", "abc", "ac", "b", "bc", "c"]

func wordGenerator(string: String) -> [String] {
    //var temp = [String]()
    let wordArray = string.map{ $0}
    let words = generateWords(from: wordArray)
    
    return words
}

func solveAnagram(anagram: String) -> [String]{
    var temp = [String]()
    let words = wordGenerator(string: anagram)
    for word in words {
        if isReal(word: word) && word.count > 1 {
            temp.append(word)
        }
    }
    return temp
}

solveAnagram(anagram: "onetwo")

func returnIntegers(word: String) -> [Int] {
    var tempWords = [String]()
    var numbers = [Int]()
    let words = solveAnagram(anagram: word)
    
    let wordMap = [ "zero": 0,
                    "one": 1,
                    "two": 2,
                    "three": 3,
                    "four": 4,
                    "five": 5,
                    "six": 6,
                    "seven":7,
                    "eight": 8,
                    "nine": 9
    ]
    for word in words {
        if wordMap.map({ $0.key}).contains(word) {
            tempWords.append(word)
        }
        
    }
    
    for word in tempWords {
        let number = wordMap[word]!
        numbers.append(number)
    }
    
    
    return numbers
}

returnIntegers(word: "onetwo")
