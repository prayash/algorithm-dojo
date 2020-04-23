
class Solution {
    func dotProduct(_ a: [[Int]], _ b: [[Int]]) -> Int {
        var i = 0
        var j = 0
        var result = 0

        while i < a.count && j < b.count {
            if a[i][0] == b[j][0] {
                result += a[i][1] * b[j][1]
                i += 1
                j += 1
            } else if a[i][0] < b[j][0] {
                i += 1
            } else {
                j += 1
            }
        }

        return result
    }
}

var a = [[1, 2], [2, 3], [100, 5]]
var b = [[0, 5], [1, 1], [100, 6]]

print(Solution().dotProduct(a, b))
