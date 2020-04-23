class Solution {
    func gameOfLife(_ board: inout [[Int]]) {
        let b = board
        let rows = b.count
        let columns = b[0].count
        let neighbors = [0, 1, -1]

        for i in 0..<rows {
            for j in 0..<columns {
                var liveNeighbors = 0

                for x in 0..<3 {
                    for y in 0..<3 {
                        if neighbors[x] != 0 && neighbors[y] == 0 {
                            let r = i + neighbors[x]
                            let c = j + neighbors[y]

                            if r < rows && r >= 0 && c < columns && c >= 0 {
                                liveNeighbors += 1
                            }
                        }
                    }
                }

                if b[i][j] == 1 && (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[i][j] = 0
                }

                if b[i][j] == 0 && liveNeighbors == 3 {
                    board[i][j] = 1
                }
            }
        }
    }
}
