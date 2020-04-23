/**
 In a row of dominoes, A[i] and B[i] represent the top and bottom halves of the i-th domino.
 (A domino is a tile with two numbers from 1 to 6 - one on each half of the tile.)

 We may rotate the i-th domino, so that A[i] and B[i] swap values.

 Return the minimum number of rotations so that all the values in A are the same, or all
 the values in B are the same.

 If it cannot be done, return -1.

 Input: A = [2,1,2,4,2,2], B = [5,2,6,2,3,2] Output: 2
 Explanation: The first figure represents the dominoes as given by A and B: before we
 do any rotations. If we rotate the second and fourth dominoes, we can make every value
 in the top row equal to 2, as indicated by the second figure.

 Input: A = [3,5,1,2,3], B = [3,6,3,3,4] Output: -1
 Explanation: It is not possible to rotate the dominoes to make one row of values equal.
 */

class Solution {
    /**
     We need the whole row to match. Therefore, if one tile does not match, we cannot
     have a matching row. We could abitrarily pick any tile, but we pick the 0th tile
     since it always exists.
     One side of the first tile MUST match at least one side of every
     single one of the other tiles, or we cannot have an equal row.
     */
    func minDominoRotations(_ A: [Int], _ B: [Int]) -> Int {
        func check(target: Int) -> Int {
            var rotationsA = 0
            var rotationsB = 0

            for i in 0..<A.count {
                if A[i] != target && B[i] != target {
                    return -1
                } else if A[i] != target {
                    rotationsA += 1
                } else if B[i] != target {
                    rotationsB += 1
                }
            }

            return min(rotationsA, rotationsB)
        }

        let rotations = check(target: B[0])
        if (rotations != -1) || (A[0] == B[0]) {
            return rotations
        } else {
            return check(target: A[0])
        }
    }
}

var A = [2,1,2,4,2,2]
var B = [5,2,6,2,3,2]
print(Solution().minDominoRotations(A, B))

A = [3,5,1,2,3]
B = [3,6,3,3,4]
print(Solution().minDominoRotations(A, B))
