/**
 In English, we have a concept called root, which can be followed by some other words to
 form another longer word - let's call this word successor. For example, the root an, followed
 by other, which can form another word another.

 Now, given a dictionary consisting of many roots and a sentence. You need to replace all
 the successor in the sentence with the root forming it. If a successor has many roots can
 form it, replace it with the root with the shortest length.

 You need to output the sentence after the replacement.

 Example 1:
 Input: dict = ["cat", "bat", "rat"]
 sentence = "the cattle was rattled by the battery"
 Output: "the cat was rat by the bat"
 */

class Solution {
    /**
     Build a trie from the root words, storing the root word as field in the terminal trie node.
     We'll then process the input sentence, terminating at the root nodes every word.
     - Complexity: O(n) where n is the length of the sentence. Every query of a word is O(n). O(n) space.
     */
    func replaceWords(_ dict: [String], _ sentence: String) -> String {
        let trie = TrieNode()

        for root in dict {
            var current = trie

            for char in root {
                if current.children[char] == nil {
                    current.children[char] = TrieNode()
                }

                current = current.children[char]!
            }

            current.word = root
            current.isTerminal = true
        }

        var res = [String]()
        for word in sentence.split(separator: " ") {
            var current = trie

            for letter in word {
                if current.children[letter] == nil || current.isTerminal {
                    break
                }

                current = current.children[letter]!
            }

            res.append(current.isTerminal ? current.word : String(word))
        }

        return res.joined(separator: " ")

    }
}

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var word: String = ""
    var isTerminal: Bool = false
}

print(Solution().replaceWords(["cat", "bat", "rat"], "the cattle was rattled by the battery"))
