/**
 Given a 2D board and a list of words from the dictionary, find all words in the board.

 Each word must be constructed from letters of sequentially adjacent cell, where "adjacent"
 cells are those horizontally or vertically neighboring. The same letter cell may not be
 used more than once in a word.

     Input:
     board = [
       ['o','a','a','n'],
       ['e','t','a','e'],
       ['i','h','k','r'],
       ['i','f','l','v']
     ]
     words = ["oath","pea","eat","rain"]
     Output: ["eat","oath"]
 */

class Solution {
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isTerminal: Bool = false
        var word: String = ""
    }

    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        var board = board
        var result = [String]()

        func backtrack(_ row: Int, _ col: Int, _ node: TrieNode) {
            let char = board[row][col]
            guard let currentNode = node.children[char] else { return }

            if currentNode.isTerminal {
                result.append(currentNode.word)

                // We''ll unmark this as a leaf with a word to avoid duplicates
                currentNode.word = ""
                currentNode.isTerminal = false
            }

            // Mark as visited
            board[row][col] = "#"

            // Explore neighbor cells
            let rowDirections = [-1, 0, 1, 0]
            let colDirections = [0, 1, 0, -1]
            for d in 0..<rowDirections.count {
                let ii = row + rowDirections[d]
                let jj = col + colDirections[d]
                let withinBounds = ii >= 0 && ii < board.count && jj >= 0 && jj < board[0].count

                if withinBounds, let _ = currentNode.children[board[ii][jj]] {
                    backtrack(ii, jj, currentNode)
                }
            }

            // End of exploration, set the character back to original
            board[row][col] = char

            if currentNode.children.isEmpty {
                node.children.removeValue(forKey: char)
            }
        }

        // Construct the Trie
        let root = TrieNode()
        for word in words {
            var currentNode = root

            for char in word {
                if let childNode = currentNode.children[char] {
                    currentNode = childNode
                } else {
                    let childNode = TrieNode()
                    currentNode.children[char] = childNode
                    currentNode = currentNode.children[char]!
                }
            }

            currentNode.word = word
            currentNode.isTerminal = true
        }

        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if let _ = root.children[board[i][j]] {
                    backtrack(i, j, root)
                }
            }
        }

        return result
    }
}

let words = ["oath","pea","eat","rain"]
//let words = ["oath"]
let board: [[Character]] = [
  ["o","a","a","n"],
  ["e","t","a","e"],
  ["i","h","k","r"],
  ["i","f","l","v"]
]

print(Solution().findWords(board, words))
