///
/// Cartesian Product:
/// the product of two sets: the product of set X and set Y is the set that contains all ordered pairs ( x, y ) for which x belongs to X and y belongs to Y.
/// A = [1, 2, 3]
/// B = [4, 5]
/// C = [6, 7, 8]
/// A*B = [[1, 4], [1, 5], [2, 4], [2, 5], [3, 4], [3, 5]]
/// A*B*C = [[1, 4, 6], [1, 4, 7], ..., [3, 5, 8]]
///
/// Write a function that takes an array of arrays as input and returns the cartesian product (also an array of arrays).
///
class Solution {
    func cartesianProduct(of input: [[Int]]) -> [[Int]] {
        var result: [[Int]] = []
        var temp: [Int] = input.first!
        var candidate: [Int] = []
        
        for i in 1..<input.count {
            helper(temp, input[i], candidate: &candidate, output: &result, index: 0)
        }
        
        return result
    }
    
    private func helper(
        _ setA: [Int],
        _ setB: [Int],
        candidate: inout [Int],
        output: inout [[Int]],
        index: Int
    ) {
        if candidate.count == 3 {
            output.append(candidate)
            return
        }
        
        for i in 0..<setB.count {
            candidate.append(setB[i])
            helper(set, input, candidate: &candidate, output: &output, index: i + 1)
            candidate.removeLast()
        }
    }
}

print(Solution().cartesianProduct(of: [[1, 2, 3], [4, 5]]))
