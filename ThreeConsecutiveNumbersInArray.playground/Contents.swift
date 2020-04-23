/**
 Given 2 arrays of numbers, return true if 3 consecutive numbers in array A, add up to a number
 in array B. Return false otherwise.
 */

class Solution {
    func hasConsecutiveSumNaive(_ A: [Int], _ B: [Int]) -> Bool {
        let set = Set<Int>(B)

        for i in 0..<A.count - 2 {
            let j = i + 2
            let sum = A[i...j].reduce(0, +)

            if set.contains(sum) {
                return true
            }
        }

        return false
    }

    func hasConsecutiveSum(_ A: [Int], _ B: [Int]) -> Bool {
        let set = Set<Int>(B)
        var i = 2
        var sum = 0
        var prev = 0

        while i < A.count {
            sum = A[i] + A[i - 1] + A[i - 2]
            prev = A[i - 2]

            if set.contains(sum) {
                return true
            }

            i += 1
            sum -= prev
        }

        return false
    }
}

print(Solution().hasConsecutiveSum([1, 2, 4, 5, 6], [3, 11]))
print(Solution().hasConsecutiveSum([1, 2, 4, 5, 6], [4, 110]))
