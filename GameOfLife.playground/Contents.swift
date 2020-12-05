
/// The Game of Life, also known simply as Life, is a cellular automaton devised by the
/// British mathematician John Horton Conway in 1970.
/// Given a board with m by n cells, each cell has an initial state live (1) or dead (0). Each cell
/// interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules:
///
/// - Any live cell with fewer than two live neighbors dies, as if caused by under-population.
/// - Any live cell with two or three live neighbors lives on to the next generation.
/// - Any live cell with more than three live neighbors dies, as if by over-population..
/// - Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
///
/// Write a function to compute the next state (after one update) of the board given its current state.
/// The next state is created by applying the above rules simultaneously to every cell in the current
/// state, where births and deaths occur simultaneously.
///
/// Follow up:
/// 1. Could you solve it in-place? Remember that the board needs to be updated at the same time:
/// You cannot update some cells first and then use their updated values to update other cells.
/// 2. In this question, we represent the board using a 2D array. In principle, the board is infinite, which
/// would cause problems when the active area encroaches the border of the array. How would you address these problems?

class Solution {
    
    /// Possible search spaces for each cell.
    private let directions: [(Int, Int)] = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    
    /// Captures a cell's state history.
    enum CellStateTransition: Int {
        case aliveToAlive = 3
        case deadToAlive = 2
        case aliveToDead = 1
        case deadToDead = 0
    }
    
    /// Loop over the matrix, compute the new state using a custom type to capture the state transition.
    ///
    /// This allows us to take a single pass through the board and mutate it without updating the subsequent cells with updated states.
    /// We always want to dip into the original board state when computing the board's new state.
    /// - Complexity:
    ///     - `O(M * N)` run time. Unavoidable.
    ///     - `O(1)` space since we can now freely mutate the board in-place without making an extra copy.
    func gameOfLife(_ board: inout [[Int]]) {
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                let numLiveNeighbors = searchUsingTransitionState(at: [row, col], in: board)
                let computedState = determineState(for: board[row][col], with: numLiveNeighbors)
                
                board[row][col] = computedState.rawValue
            }
        }
        
        convertToFinalState(&board)
    }
    
    /// Compute a new state for a given cell, capturing the state transition using the `CellStateTransition` enum.
    private func determineState(for state: Int, with numberOfAliveNeighbors: Int) -> CellStateTransition {
        guard state == 1 else {
            return numberOfAliveNeighbors == 3 ? .deadToAlive : .deadToDead
        }
        
        if numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3 {
            return .aliveToAlive
        }
        
        if numberOfAliveNeighbors < 2 || numberOfAliveNeighbors > 3 {
            return .aliveToDead
        }
        
        return .aliveToAlive
    }
    
    /// Private helper for kicking off a search for live neighbors given a cell.
    /// Use the `CellStateTransition` to figure out the true value of the cell before they were mutated.
    private func searchUsingTransitionState(at: [Int], in board: [[Int]]) -> Int {
        var count: Int = 0

        for direction in directions {
            let row = at[0] + direction.0
            let col = at[1] + direction.1

            guard row >= 0, col >= 0, row < board.count, col < board[row].count else {
                continue
            }
            
            // While we're searching, we'll use the cell's state history to determine whether something was alive in the original state.
            if let stateTransition = CellStateTransition.init(rawValue: board[row][col]) {
                switch stateTransition {
                case .aliveToAlive, .aliveToDead: count += 1
                default: break
                }
            }
        }
        
        return count
    }
    
    /// Using the `CellStateTransition` enum, we now can transition the values back to 1's or 0's.
    private func convertToFinalState(_ board: inout [[Int]]) {
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                if let stateTransition = CellStateTransition.init(rawValue: board[row][col]) {
                    switch stateTransition {
                    case .aliveToAlive, .deadToAlive:
                        board[row][col] = 1
                    case .aliveToDead, .deadToDead:
                        board[row][col] = 0
                    }
                }
            }
        }
    }
    
    /// Suboptimal solution. Unavoidable runtime because it's a matrix, but can we utilize space better? `O(1)` space would be ideal.
    /// We're making a copy of the board to preserve its original state so we can compute the entire new state in one pass.
    /// - Complexity:
    ///     - `O(M * N * 8)` time where `m` is the number of rows and `n` is the number of columns PLUS 8 iterations for each cell searching its neighbors.
    ///     - `O(M * N)` space for creating a duplicate copy of the board. Not good.
    func gameOfLifeUsingCopy(_ board: inout [[Int]]) {
        let boardCopy = board
        
        for row in 0..<boardCopy.count {
            for col in 0..<boardCopy[row].count {
                let numLiveNeighbors = search(at: [row, col], in: boardCopy)
                print("Live neighbors at: \([row, col]): \(numLiveNeighbors)")
                let currentCell = boardCopy[row][col]
                
                guard currentCell == 1 else {
                    // Dead cells become alive only if there are 3 live neighbors.
                    board[row][col] = numLiveNeighbors == 3 ? 1 : 0
                    continue
                }
                
                board[row][col] = determineState(for: numLiveNeighbors)
            }
        }
    }
    
    /// Computes a new state given a number of alive neighbors.
    private func determineState(for numberOfAliveNeighbors: Int) -> Int {
        if numberOfAliveNeighbors == 3 || numberOfAliveNeighbors == 2 {
            return 1
        }
        
        if numberOfAliveNeighbors < 2 || numberOfAliveNeighbors > 3 {
            return 0
        }
        
        return 0
    }
    
    /// Private helper for kicking off a search for live neighbors given a cell.
    private func search(at: [Int], in board: [[Int]]) -> Int {
        var count: Int = 0

        for direction in directions {
            let row = at[0] + direction.0
            let col = at[1] + direction.1

            if row >= 0 && col >= 0 && row < board.count && col < board[row].count, board[row][col] == 1 {
                count += 1
            }
        }
        
        return count
    }
}

var testBoard = [
    [0, 1, 0],
    [0, 0, 1],
    [1, 1, 1],
    [0, 0, 0]
]

Solution().gameOfLife(&testBoard)
print(testBoard)
