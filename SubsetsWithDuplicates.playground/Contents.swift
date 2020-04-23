/**
 Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).
 Note: The solution set must not contain duplicate subsets.

     Input: [1,2,2]
     Output:
     [
       [2],
       [1],
       [1,2,2],
       [2,2],
       [1,2],
       []
     ]
 */

class Solution {
    /**
     Backtracking solution.
     - Complexity: O(n! + n log n) time and O(n!) space
     */
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var output = [[Int]]()
        let sorted = nums.sorted()

        backtrack(&output, sorted, [], 0)
        return output
    }

    private func backtrack(_ o: inout [[Int]], _ n: [Int], _ temp: [Int], _ start: Int) {
        var temp = temp
        o.append(temp)

        for i in start..<n.count {
            // Skip duplicates (the list is sorted)
            if i > start && n[i] == n[i - 1] {
                continue
            }

            temp.append(n[i])
            backtrack(&o, n, temp, i + 1)
            temp.removeLast()
        }
    }
}

print(Solution().subsetsWithDup([1, 2, 2]))
