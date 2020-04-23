class Solution {
    func printPattern(_ n: Int) {
        var res = ""
        for i in stride(from: n + 1, to: 0, by: -1) {
            var j = i - 1
            while j > 0 && j <= n {
                res += "\(j) "
                j += 1
            }
        }

        print(res)
    }
}

Solution().printPattern(3)
