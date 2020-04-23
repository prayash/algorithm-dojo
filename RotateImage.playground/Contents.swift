class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        matrix = matrix.rotated()
    }
}

func rotate(_ matrix: inout [[Int]]) {
    for i in 0..<matrix.count {
        for j in i + 1..<matrix[i].count {
            let temp = matrix[i][j]

            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
        }

//        matrix[i].reverse()
    }
}

extension RandomAccessCollection where Iterator.Element: RandomAccessCollection,
Iterator.Element.Index == Index, Indices.Iterator.Element == Index {
    func rotated() -> [[Iterator.Element.Iterator.Element]] {
        precondition(self.count == self.first?.count, "Matrix must be square!")

        var rotated: [[Iterator.Element.Iterator.Element]] = []

        for col in indices {
            var rotatedRow: [Iterator.Element.Iterator.Element] = []
            for row in self {
                rotatedRow.append(row[col])
            }

            rotated.append(rotatedRow.reversed())
        }

        return rotated
    }
}

var m = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]

rotate(&m)

print(m)
