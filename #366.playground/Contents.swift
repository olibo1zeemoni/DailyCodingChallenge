func rearrangeString(s: String) -> String? {
    // Create a frequency map for each character in the string
    var freqMap = [Character: Int]()
    for ch in s {
        if freqMap[ch] == nil {
            freqMap[ch] = 1
        } else {
            freqMap[ch]! += 1
        }
    }

    // Sort the frequency map in descending order by frequency
    let sortedFreqMap = freqMap.sorted { $0.value > $1.value }

    // Initialize the result string with the first character and its frequency
    var result = String(repeating: sortedFreqMap[0].key, count: sortedFreqMap[0].value)

    // Iterate through the sorted frequency map and try to append the characters to the result string
    for (ch, freq) in sortedFreqMap[1...] {
        let lastChar = result.last!
        if ch == lastChar {
            // If the current character is the same as the last character in the result string, return nil
            return nil
        }

        // Append the current character to the result string
        result.append(ch)

        // Decrement the frequency of the current character
        freqMap[ch]! -= 1

        // If the current character has a frequency of 0, remove it from the frequency map
        if freqMap[ch] == 0 {
            freqMap.removeValue(forKey: ch)
        }
    }

    return result
}

