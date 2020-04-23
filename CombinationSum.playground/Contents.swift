/**
 Given a set of candidate numbers (candidates) (without duplicates) and a target number (target),
 find all unique combinations in candidates where the candidate numbers sums to target.
 The same repeated number may be chosen from candidates unlimited number of times.

 Note:
 All numbers (including target) will be positive integers.
 The solution set must not contain duplicate combinations.

 Input: candidates = [2,3,6,7], target = 7,
 A solution set is:
 [
   [7],
   [2,2,3]
 ]
 */

class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        var opt = [Int]()

        bt(candidates, &result, target, &opt, 0)
        return result
    }

    func bt(_ n: [Int], _ output: inout [[Int]], _ diff: Int, _ opt: inout [Int], _ start: Int) {
        print(opt)
        if diff < 0 {
            return
        }

        if diff == 0 {
            output.append(opt)
            return
        }

        for i in start..<n.count {
            opt.append(n[i])
            bt(n, &output, diff - n[i], &opt, i)
            opt.removeLast()
        }
    }
}

print(Solution().combinationSum([2, 3, 6, 7], 7))
