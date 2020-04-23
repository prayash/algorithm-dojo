/**
 Given an integer n, count the total number of digit 1 appearing in all non-negative
 integers less than or equal to n.

 Input: 13
 Output: 6
 Explanation: Digit 1 occurred in the following numbers: 1, 10, 11, 12, 13.
 */

class Solution {
    func solve(n: Int) -> Int {
        guard n > 0 else {
            return 0
        }

        guard n > 9 else {
            return 1
        }

        let s = String(n)
        let c = s.first!
        let d = Int(String(c))!
        let i = s.index(after: s.startIndex)
        let m = Int(s[i...])!
        let p = Int(pow(10.0, Double(s.count - 1)))

        switch c {
        case "0":
            return solve(n: m)
        case "1":
            return solve(n: p - 1) + solve(n: m) + m + 1
        default:
            return d * solve(n: p - 1) + solve(n: m) + p
        }
    }

    func countDigitOne(_ n: Int) -> Int {
        return solve(n: n)
    }
}
