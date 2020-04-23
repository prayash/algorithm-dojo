class Solution {
    func gridIllumination(_ N: Int, _ lamps: [[Int]], _ queries: [[Int]]) -> [Int] {
        var rowMap = [Int: Int](), colMap = [Int: Int]()
        var diag1Map = [Int: Int](), diag2Map = [Int: Int]()
        var lamps = Set(lamps)

        for lamp in lamps {
            let i = lamp[0], j = lamp[1]
            rowMap[i, default: 0] += 1
            colMap[j, default: 0] += 1
            diag1Map[i - j, default: 0] += 1
            diag2Map[i + j, default: 0] += 1
        }

        var answers = [Int]()
        for query in queries {
            // get answer
            let i = query[0], j = query[1]
            if rowMap[i, default: 0] > 0 || colMap[j, default: 0] > 0 || diag1Map[i - j, default: 0] > 0 || diag2Map[i + j, default: 0] > 0 {
                answers.append(1)
            } else {
                answers.append(0)
            }

            // remove lamps
            for m in i-1...i+1 where m >= 0 && m < N {
                for n in j-1...j+1 where n >= 0 && n < N {
                    guard lamps.contains([m, n]) else { continue }
                    lamps.remove([m, n])
                    rowMap[m, default: 0] -= 1
                    colMap[n, default: 0] -= 1
                    diag1Map[m - n, default: 0] -= 1 // path:\
                    diag2Map[m + n, default: 0] -= 1 // path:/
                }
            }
        }
        return answers
    }
}

print(Solution().gridIllumination(5, [[0, 0], [4, 4]], [[1, 1], [1, 0]]))
