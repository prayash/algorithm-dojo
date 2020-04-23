struct MultiplicationTable: CustomStringConvertible {
    private var table: [[Int]] = []

    mutating func insert(_ row: [Int]) {
        table.append(row)
    }

    var description: String {
        var str = ""

        table.forEach { row in
            row.forEach {
                str += "\($0)\t\t"
            }

            str += "\n"
        }

        return str
    }
}

class Solution {
    func printMultiplicationTable(_ n: Int) {
        var table = MultiplicationTable()

        for i in 1...n {
            table.insert(createMultiplicationRow(i, upTo: n))
        }

        print(table)
    }

    func createMultiplicationRow(_ n: Int, upTo target: Int) -> [Int] {
        var result = [Int]()

        for i in 1...target {
            result.append(n * i)
        }

        return result
    }
}

Solution().printMultiplicationTable(12)
