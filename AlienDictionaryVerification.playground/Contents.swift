/**
 In an alien language, surprisingly they also use english lowercase letters, but possibly
 in a different order. The order of the alphabet is some permutation of lowercase letters.

 Given a sequence of words written in the alien language, and the order of the alphabet,
 return true if and only if the given words are sorted lexicographicaly in this alien language.

 Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
 Output: true. As 'h' comes before 'l' in this language, then the sequence is sorted.
 */
class Solution {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        guard words.count > 0 else { return false }

        // Build a mapping of character to sort index
        var idxMap: [Character: Int] = [:]
        for (index, char) in order.enumerated() {
            idxMap[char, default: 0] = index
        }

        print(idxMap.description)

        // Initiate search with two pointers
        search: for i in 0..<words.count - 1 {
            let first = words[i]
            let second = words[i + 1]

            // Find the difference between the two words
            for j in 0..<min(first.count, second.count) {
                let charOne = first[j]
                let charTwo = second[j]

                // Ensure the characters are different for a confident sort
                if charOne != charTwo {
                    // If the first word's char is out of sort, then we're done
                    if idxMap[charOne]! > idxMap[charTwo]! {
                        return false
                    }

                    continue search
                }
            }

            // In a case like "apple" vs "app", "app" should always come first
            if first.count > second.count {
                return false
            }
        }

        return true
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

print(Solution().isAlienSorted(["hello", "leetcode"], "hlabcdefgijkmnopqrstuvwxyz"))
print(Solution().isAlienSorted(["word", "world", "row"], "worldabcefghijkmnpqstuvxyz"))
