/**
 Given a collection of candidate numbers (candidates) and a target number (target), find
 all unique combinations in candidates where the candidate numbers sums to target.
 Each number in candidates may only be used once in the combination.

 All numbers (including target) will be positive integers.
 The solution set must not contain duplicate combinations.

 Input: candidates = [10,1,2,7,6,1,5], target = 8,
 A solution set is:
 [
   [1, 7],
   [1, 2, 5],
   [2, 6],
   [1, 1, 6]
 ]
 */

class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var output = [[Int]]()
        var opt = [Int]()

        backtrack(candidates.sorted(), &output, target, opt: &opt, start: 0)

        return output
    }

    func backtrack(_ n: [Int], _ output: inout [[Int]], _ difference: Int, opt: inout [Int], start: Int) {
        // If the number goes negative, the permutation doesn't work
        guard difference >= 0 else { return }

        if difference == 0 {
            output.append(opt)
            return
        }

        for i in start..<n.count {
            // Skip duplicates values!
            if i > start && n[i] == n[i - 1] {
                continue
            }

            opt.append(n[i])
            backtrack(n, &output, difference - n[i], opt: &opt, start: i + 1)
            opt.removeLast()
        }
    }
}

print(Solution().combinationSum2([10, 1, 2, 7, 6, 1, 5], 8))
