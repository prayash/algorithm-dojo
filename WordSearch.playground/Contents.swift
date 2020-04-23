/**
 Given a 2D board and a word, find if the word exists in the grid.
 The word can be constructed from letters of sequentially adjacent cell, where "adjacent"
 cells are those horizontally or vertically neighboring. The same letter cell may not
 be used more than once.

 Example:
 board =
 [
   ['A','B','C','E'],
   ['S','F','C','S'],
   ['A','D','E','E']
 ]

 Given word = "ABCCED", return true.
 Given word = "SEE", return true.
 Given word = "ABCB", return false.
 */

class Solution {
    /**
     DFS + backtracking approach.
     - Complexity: O(mn) space and O(mn ^ 2) time.
     */
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var board = board

        func backtrack(_ i: Int, _ j: Int, _ strIdx: Int) -> Bool {
            if strIdx == word.count {
                return true
            }

            if i < 0 || i == board.count || j < 0 || j == board[0].count {
                return false
            }

            if word[strIdx] != board[i][j] {
                return false
            }

            // Choose
            let originalChar = board[i][j]
            board[i][j] = Character("#")

            // Explore
            let up = backtrack(i - 1, j, strIdx + 1)
            let down = backtrack(i + 1, j, strIdx + 1)
            let right = backtrack(i, j + 1, strIdx + 1)
            let left = backtrack(i, j - 1, strIdx + 1)

            if up || down || left || right {
                return true
            }

            // Unchoose
            board[i][j] = originalChar

            return false
        }

        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == word[0] && backtrack(i, j, 0) {
                    return true
                }
            }
        }

        return false
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

let board: [[Character]] = [
  ["A","B","C","E"],
  ["S","F","C","S"],
  ["A","D","E","E"]
]

let board2: [[Character]] = [
    ["C","A","A"],
    ["A","A","A"],
    ["B","C","D"]
]

print(Solution().exist(board, "ABCCED"))
print(Solution().exist(board2, "AAB"))

let board3: [[Character]] = [["a"]]
print(Solution().exist(board3, "a"))
