class Solution {
    func longestCommonSubstring(_ x: String, _ y: String) -> String {
        let x = Array(x)
        let y = Array(y)
        let xLength = x.count
        let yLength = y.count
        var max = 0
        var result = ""

        for i in 0...xLength {
            for j in 0...yLength {
                var startX = i
                var startY = j
                var current = 0

                while startX < xLength && startY < yLength {
                    if x[startX] == y[startY] {
                        startX += 1
                        startY += 1
                        current += 1
                    } else {
                        if current > max {
                            max = current

                            let end = startX - 1
                            result = String(x[i...(end - i + 1)])
                        }

                        break
                    }
                }
            }
        }

        return String(result)
    }
}

var x = "HelloWorld"
var y = "HiWorld"

print(Solution().longestCommonSubstring(x, y))
