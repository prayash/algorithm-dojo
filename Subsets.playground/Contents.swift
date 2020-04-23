/**
 Given a set of distinct integers, nums, return all possible subsets (the power set).
 Note: The solution set must not contain duplicate subsets.

     Input: nums = [1,2,3]
     Output:
     [
       [3],
       [1],
       [2],
       [1,2,3],
       [1,3],
       [2,3],
       [1,2],
       []
     ]
 */

class Solution {
    /**
     Backtracking solution: Recursively calculate subsets.
     - Complexity: O(n!) time and O(n) space.
     */
    func subsets(_ nums: [Int]) -> [[Int]] {
        var output = [[Int]]()

        backtrack(&output, nums, temp: [], start: 0)
        return output
    }

    private func backtrack(_ output: inout [[Int]], _ nums: [Int], temp: [Int], start: Int) {
        var temp = temp
        output.append(temp)

        for i in start..<nums.count {
            temp.append(nums[i])
            backtrack(&output, nums, temp: temp, start: i + 1)
            temp.removeLast()
        }
    }
}

print(Solution().subsets([1, 2, 3]))
