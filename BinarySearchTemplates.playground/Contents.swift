/**
 Standard binary search.
 Key attributes:
     - Most basic and elementary form of Binary Search
     - Search Condition can be determined without comparing to the element's
         neighbors (or use specific elements around it)
     - No post-processing required because at each step, you are checking to see
         if the element has been found. If you reach the end, then you know the element is not found
 */
class StandardBinarySearch {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1

        while left < right {
            let mid = left + ((right - left) / 2)

            if nums[mid] == target {
                return mid
            }

            if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }

        return -1
    }
}

print(StandardBinarySearch().search([-1,0,3,5,9,12], 9))
print(StandardBinarySearch().search([-1,0,3,5,9,12], 2))
