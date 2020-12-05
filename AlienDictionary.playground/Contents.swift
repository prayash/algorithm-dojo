/**
 There is a new alien language which uses the latin alphabet. However, the order among
 letters are unknown to you. You receive a list of non-empty words from the dictionary, where
 words are sorted lexicographically by the rules of this new language. Derive the order of
 letters in this language.

 You may assume all letters are in lowercase.
 You may assume that if a is a prefix of b, then a must appear before b in the given dictionary.
 If the order is invalid, return an empty string.
 There may be multiple valid order of letters, return any one of them is fine.

 Example 1:

     Input:
     [
       "wrt",
       "wrf",
       "er",
       "ett",
       "rftt"
     ]

     Output: "wertf"
 */
class Solution {
    func alienOrder(_ words: [String]) -> String {
        var adj = [Character: Set<Character>]()
        var indegree = [Character: Int]()

        words.forEach {
            $0.forEach { c in indegree[c] = 0 }
        }

        print(indegree)

        // Build adjacency list
        for i in 0..<words.count - 1 {
            let first = words[i], second = words[i + 1]

            for j in 0..<min(first.count, second.count) {
                let charOne = first[j], charTwo = second[j]

                if charOne == charTwo {
                    continue
                }

                if adj[charOne] == nil {
                     adj[charOne] = Set<Character>()
                }

                if !adj[charOne]!.contains(charTwo) {
                    adj[charOne]!.insert(charTwo)
                    indegree[charTwo]! += 1
                }

                break
            }
        }

        // Initialize a queue to all characters with in-degree of 0
        var queue = [Character]()
        for (k, v) in indegree {
            if v == 0 {
                queue.append(k)
            }
        }

        print("Indegrees:", indegree)
        print("Adjacency List:", adj.debugDescription)

        // BFS, explore neighbors and calculate new in-degrees
        var result = ""
        while !queue.isEmpty {
            let curr = queue.removeFirst()
            result += "\(curr)"

            if let neighbors = adj[curr] {
                for n in neighbors {
                    indegree[n] = indegree[n]! - 1

                    if indegree[n] == 0 {
                        queue.append(n)
                    }
                }
            }
        }

        // Detect cycle - if there is a mismatch in in-degrees, then there's a cycle.
        if result.count == indegree.count {
            return result
        }

        return ""
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

var words = ["wrt", "wrf", "er", "ett", "rftt"]
print(Solution().alienOrder(words) == "wertf")
