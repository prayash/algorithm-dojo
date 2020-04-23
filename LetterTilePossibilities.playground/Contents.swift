/**
 You have a set of tiles, where each tile has one letter tiles[i] printed on it.
 Return the number of possible non-empty sequences of letters you can make.

 Example 1:
 Input: "AAB"
 Output: 8
 Explanation: The possible sequences are "A", "B", "AA", "AB", "BA", "AAB", "ABA", "BAA".

 Example 2:
 Input: "AAABBC"
 Output: 188
 */

class Solution {
    func numTilePossibilities(_ tiles: String) -> Int {
        var count = [Int].init(repeating: 0, count: 26)
        let offset = Character("A").asciiValue ?? 0

        for char in tiles {
            guard let ascii = char.asciiValue else { return 0 }
            let asciiIdx = Int(ascii - offset)

            count[asciiIdx] += 1
        }

        return dfs(&count)
    }

    private func dfs(_ count: inout [Int]) -> Int {
        var sum = 0

        for i in 0..<26 {
            // No letters left!
            if count[i] == 0 {
                continue
            }

            // With the current tile given, we already have a valid combination
            sum += 1

            // We've used the current letter, so decrement its count
            count[i] -= 1

            // If we still want to add more tiles to the existing combo, recurse
            sum += dfs(&count)

            // Backtracking, we finished exploring, so let's add the count back!
            count[i] += 1
        }

        return sum
    }
}

print(Solution().numTilePossibilities("AAB"))
print(Solution().numTilePossibilities("AAABBC"))
