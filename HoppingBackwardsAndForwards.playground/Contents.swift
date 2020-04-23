/**
 Jack is hopping backwards and forwards in an array of size n. He starts in cell 0 and can hop f
 cells forwards or b cells backwards. He is allowed to jump up to max_jumps times. How many ways
 can he reach the last cell and finish the game?
 */

class Solution {
    func numWays(_ n: Int, _ f: Int, _ b: Int, maxJumps: Int) -> Int {
        var arr = [Int].init(repeating: 0, count: n)
        var cache: [Tuple<Int, Int>: Int] = [:]

        func helper(_ currentIdx: Int, _ jumpsLeft: Int) -> Int {
            // Some base-cases:
            // If we're at the end...
            if currentIdx == n - 1 {
                return 1
            }

            // If we're out of bounds or have no jumps left...
            if currentIdx < 0 || currentIdx >= n || jumpsLeft == 0 {
                return 0
            }

            // Create a tuple-based key for our current position + jumps left
            let key = Tuple(values: (currentIdx, jumpsLeft))

            // Extract memoized value if possible
            if let cachedVal = cache[key] {
                return cachedVal
            }

            // Recursively calculate
            let back = helper(currentIdx - b, jumpsLeft - 1)
            let forward = helper(currentIdx + f, jumpsLeft - 1)
            let numMoves = back + forward

            // Memoize our calculation
            cache[key, default: 0] = numMoves
            return numMoves
        }

        return helper(0, maxJumps)
    }
}

struct Tuple<T: Hashable, U: Hashable>: Hashable {

    let values: (T, U)

    func hash(into hasher: inout Hasher) {
        let (a, b) = values

        hasher.combine(a)
        hasher.combine(b)
    }

    static func == (lhs: Tuple<T, U>, rhs: Tuple<T, U>) -> Bool {
        return lhs.values == rhs.values
    }
}

print(Solution().numWays(11, 5, 2, maxJumps: 9))
print(Solution().numWays(11, 5, 2, maxJumps: 6))
print(Solution().numWays(11, 5, 2, maxJumps: 2))
