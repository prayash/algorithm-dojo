class Solution {
    func reverseWords(_ s: String) -> String {
        var s = Array(s)

        var i = 0, j = s.count - 1
        while i < j {
            s.swapAt(i, j)

            i += 1
            j -= 1
        }

        return String(s)
    }
}

print(Solution().reverseWords("swift is fun"))
