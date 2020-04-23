/**
 Given a collection of numbers that might contain duplicates, return all possible unique permutations.

     Input: [1,1,2]
     Output:
     [
       [1,1,2],
       [1,2,1],
       [2,1,1]
     ]

     Example: [1, 1, 2]; assume it's like a tree; "*" means duplicated cases, "@" means who have same
     value of its previous' sibling
                               [ ]
                  /             |                \
                [1]            [@1]               [2]
               /   \          /   \             /   \
           [1,1]  [1,2]    *[1,1] *[1,2]      [2,1]  [2,@1]
             /       \       /        \        /       \
         [1,1,2]  [1,2,1] *[1,1,2]  *[1,2,1] [2,1,1]  *[2,1,1]

      Output: [[1,1,2],[1,2,1],[2,1,1]]
 */

class Solution {
    /**
     Backtracking solution. Very similar to generating permutations, but this time we'll sort the
     input list and check against adjacent values to avoid duplicates.
     - Complexity: O(n * n!) time and O(n) space
     */
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 0 else {
            return []
        }

        // We'll sort to make sure we can skip the same value
        let sorted = nums.sorted()

        var candidates = [Int]()
        var output = [[Int]]()
        var visited = Array(repeating: false, count: nums.count)

        backtrack(sorted, &candidates, &output, &visited)

        return output
    }

    private func backtrack(_ nums: [Int], _ candidates: inout [Int], _ output: inout [[Int]], _ visited: inout [Bool]) {
        // Abort once we reach a leaf
        guard candidates.count < nums.count else {
            output.append(candidates)
            return
        }

        for i in 0..<nums.count where !visited[i] {
            // If we have a duplicate value that we haven't visited
            if i > 0 && nums[i - 1] == nums[i] && !visited[i - 1] {
                continue
            }

            candidates.append(nums[i])
            visited[i] = true

            backtrack(nums, &candidates, &output, &visited)

            candidates.removeLast()
            visited[i] = false
        }
    }
}

var nums = [1, 1, 2]
print(Solution().permuteUnique(nums))
