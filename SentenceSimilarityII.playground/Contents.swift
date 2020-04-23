/**
 Given two sentences words1, words2 (each represented as an array of strings), and a list of similar word pairs pairs, determine if two sentences are similar.

 For example, words1 = ["great", "acting", "skills"] and words2 = ["fine", "drama", "talent"] are similar, if the similar word pairs are pairs = [["great", "good"], ["fine", "good"], ["acting","drama"], ["skills","talent"]].

 Note that the similarity relation is transitive. For example, if "great" and "good" are similar, and "fine" and "good" are similar, then "great" and "fine" are similar.

 Similarity is also symmetric. For example, "great" and "fine" being similar is the same as "fine" and "great" being similar.

 Also, a word is always similar with itself. For example, the sentences words1 = ["great"], words2 = ["great"], pairs = [] are similar, even though there are no specified similar word pairs.

 Finally, sentences can only be similar if they have the same number of words. So a sentence like words1 = ["great"] can never be similar to words2 = ["doubleplus","good"].
 */

class Solution {
    typealias Graph = [String: Set<String>]

    /**
     DFS to find whether two words are in the same graph.
     - Complexity: O(n * p) where n is length of words1 and p is the length of pairs. Since we're building
     the graph based on pairs, that's O(p). For each word in words1, we DFS the whole graph, and there are n
     words in words1.
     */
    func areSentencesSimilarTwo(_ words1: [String], _ words2: [String], _ pairs: [[String]]) -> Bool {
        guard words1.count == words2.count else {
            return false
        }

        // Build the graph according to the similar word pairs. Each word is a graph node.
        var graph: [String: Set<String>] = [:]
        for p in pairs {
            graph[p[0], default: Set<String>()].insert(p[1])
            graph[p[1], default: Set<String>()].insert(p[0])
        }

        print(graph.description)

        // For each word in words1, we do DFS search to see if the corresponding word is existing in words2.
        for i in 0..<words1.count {
            if words1[i] == words2[i] {
                continue
            }

            if graph[words1[i]] == nil {
                return false
            }

            var visited = Set<String>()
            if !dfs(graph, words1[i], words2[i], &visited) {
                return false
            }
        }

        return true
    }

    func dfs(_ g: Graph, _ source: String, _ target: String, _ visited: inout Set<String>) -> Bool {
        guard let neighbors = g[source] else { return false }

        if neighbors.contains(target) {
            return true
        }

        visited.insert(source)
        for n in neighbors {
            if !visited.contains(n) && dfs(g, n, target, &visited) {
                return true
            }
        }

        return false
    }

}

print(Solution().areSentencesSimilarTwo(
    ["great","acting","skills"],
    ["fine","drama","talent"],
    [["great","good"],["fine","good"],["drama","acting"],["skills","talent"]]
))

