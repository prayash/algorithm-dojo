/**
 Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

 Only one letter can be changed at a time.
 Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
 Note:

 Return 0 if there is no such transformation sequence.
 All words have the same length.
 All words contain only lowercase alphabetic characters.
 You may assume no duplicates in the word list.
 You may assume beginWord and endWord are non-empty and are not the same.
 */

class Solution {
    typealias Pair = (word: String, level: Int)

    /**
     BFS.
     - Complexity: O(m * n) where m is the length of the words and n is the total number of words
     in the input word list.
     */
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        let length = beginWord.count

        // Pre-processing.
        // We'll create a dictionary with generic versions of words as keys, and possible
        // 1-char transformations as values, like... lo*: [lot, log]. We now have an adjacency list.
        var allCombos: [String: [String]] = [:]
        wordList.forEach {
            let word = Array($0)
            for i in 0..<length {
                let newWord = String(word[0..<i] + "*" + word[i + 1..<length])
                var transformations = allCombos[newWord, default: []]

                transformations.append($0)
                allCombos[newWord] = transformations
            }
        }

        print(allCombos.description)

        var bfsQueue: [Pair] = [(word: beginWord, level: 1)]
        var visited = Set<String>()
        visited.insert(beginWord)

        while !bfsQueue.isEmpty {
            let node = bfsQueue.removeFirst()
            let word = Array(node.word)
            let level = node.level

            // Find all generic transformations of the current word, and see if these
            // transformations exist in the allCombos dictionary
            for i in 0..<length {
                let newWord = String(word[0..<i] + "*" + word[i + 1..<length])

                // The list we'll get back is a collection of words which have a common
                // intermediate state with the current word, so these are adjacent in the graph
                if let neighboringWords = allCombos[newWord] {
                    for adjWord in neighboringWords {
                        if adjWord == endWord {
                            return level + 1
                        }

                        if !visited.contains(adjWord) {
                            visited.insert(adjWord)
                            bfsQueue.append((word: adjWord, level: level + 1))
                        }
                    }
                }
            }
        }

        return 0
    }
}

print(Solution().ladderLength("hit", "cog", ["hot","dot","dog","lot","log","cog"]))

