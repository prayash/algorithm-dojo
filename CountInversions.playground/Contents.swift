/**
 In an array, `arr`, the elements at indices `i` and `j` (where `i` is less than `j`) form an
 inversion if `arr[i]` is greater than `arr[j]`. In other words, inverted elements `arr[i]` and `arr[j]`
 are considered to be "out of order". To correct an inversion, we can swap adjacent elements.

 For example, consider the dataset `arr = [2, 4, 1]`. It has two inversions: (4, 1) and (2, 1). To
 sort the array, we must perform the following two swaps to correct the inversions:

 `arr = [2, 4, 1] = swap(arr[1], arr[2]) and swap(arr[0], arr[1]) -> [1, 2, 4]`

 Given d datasets, print the number of inversions that must be swapped to sort each dataset on a new line.
 */
class Solution {
    func countInversions(_ arr: [Int]) -> Int {
        let n = arr.count
        var arr = arr
        guard n > 1 else { return 0 }

        let mid = n / 2
        let left = Array(arr[0..<mid])
        let right = Array(arr[mid..<n])
        var inversions = countInversions(left) + countInversions(right)

        let range = n - mid
        var iLeft = 0
        var iRight = 0

        for i in 0..<n {
            if iLeft < mid && (iRight >= range || left[iLeft] <= right[iRight]) {
                arr[i] = left[iLeft]
                inversions += iRight
                iLeft += 1
            } else if iRight < range {
                arr[i] = right[iRight]
                iRight += 1
            }
        }

        return inversions
    }
}

print(Solution().countInversions([2, 4, 1]))
