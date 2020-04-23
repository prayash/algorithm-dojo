/**
 Given a collection of distinct integers, return all possible permutations.
 Example:

     Input: [1,2,3]
     Output:
     [
       [1,2,3],
       [1,3,2],
       [2,1,3],
       [2,3,1],
       [3,1,2],
       [3,2,1]
     ]
 */

class Solution {
    /**
     Backtracking approach. In the first level of the tree, we have N options and for each of the
     option, we have n - 1 options, and for each of these n - 1 options, we have another n - 2
     options, so putting them together you would end up n * (n - 1) * (n - 2).
     - Complexity: O(n * n!). There are n! permutations, for each we run exactly n recursive calls to reach it.
     */
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 0 else {
            return []
        }

        var output: [[Int]] = []
        var candidate = [Int]()

        backtrack(&output, &candidate, nums)

        return output
    }

    func backtrack(_ output: inout [[Int]], _ candidate: inout [Int], _ nums: [Int]) -> () {
        // We know we've created permutation once it's the same length as the input
        if candidate.count == nums.count {
            output.append(candidate)
            print("Calculated permutation. Returning to call stack.\n")
            return
        }

        for num in nums {
            if candidate.contains(num) {
                continue
            }

            candidate.append(num)
            print("Firing backtrack(\(output), candidate: \(candidate)")
            backtrack(&output, &candidate, nums)
            candidate.removeLast()
        }
    }
}

print(Solution().permute([1, 2, 3]))
