class Solution {
    // Linear scan: O(n) time!
    func peakIndexInMountainArrayLinear(_ A: [Int]) -> Int {
        var i = 0

        while A[i] < A[i + 1] {
            i += 1
        }

        return i
    }

    // Binary search method: O(log n) run time!
    func peakIndexInMountainArray(_ A: [Int]) -> Int {
        var left = 0
        var right = A.count - 1

        while left < right {
            // Find midpoint between left and right indices
            let mid = left + (right - left) / 2

            // Look for decrease in altitude to find the peak
            if A[mid] < A[mid + 1] {
                left = mid + 1
            } else {
                right = mid
            }
        }

        return left
    }
}

print(Solution().peakIndexInMountainArray([0, 2, 1, 0]))
print(Solution().peakIndexInMountainArray([1, 2, 3, 4, 1]))
