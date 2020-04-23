/**
 Top-down approach for Merge Sort (a stable-sort staple).
 O(n log n) time. O(n) space.
 The only disadvantage is that it needs a bunch of space for the temp array,
 unlike Quicksort which is an in-place sorting routine. Initial sorted-ness
 doesn't matter since we're going to be splitting em all the way down regardless.
 */
class Solution {
    func mergeSort(_ arr: [Int]) -> [Int] {
        // Base condition, the array can't be split anymore.
        guard arr.count > 1 else {
            return arr
        }

        // Partition the collection recursively until they are reduced to 1-element arrays.
        let middle = arr.count / 2
        let left = mergeSort(Array(arr[0..<middle]))
        let right = mergeSort(Array(arr[middle..<arr.count]))

        // Merge by pairing sequentially.
        return merge(left, right)
    }

    func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        // We'll allocate space for the merged array
        var result: [Int] = []
        result.reserveCapacity(left.count + right.count)

        // Two pointers to keep track of progress during merging
        var i = 0
        var j = 0

        // Compare left and right sides and append accordingly
        while i < left.count && j < right.count {
            let leftElement = left[i]
            let rightElement = right[j]

            if leftElement < rightElement {
                result.append(leftElement)
                i += 1
            } else if leftElement > rightElement {
                result.append(rightElement)
                j += 1
            } else {
                // If they're both equal, order doesn't matter!
                result.append(leftElement)
                i += 1

                result.append(rightElement)
                j += 1
            }
        }

        // If either one of the arrays are done being iterated on, we can
        // just tack on the remaining values from the remaining array since there's
        // no need for comparison anymore.
        while i < left.count {
            result.append(left[i])
            i += 1
        }

        while j < right.count {
            result.append(right[j])
            j += 1
        }

        return result
    }
}

let x = [7, 2, 6, 3, 9]
print(Solution().mergeSort(x))
