/**
 A conveyor belt has packages that must be shipped from one port to another within D days.

 The i-th package on the conveyor belt has a weight of weights[i].  Each day, we load the
 ship with packages on the conveyor belt (in the order given by weights). We may not load
 more weight than the maximum weight capacity of the ship.

 Return the least weight capacity of the ship that will result in all the packages on the
 conveyor belt being shipped within D days.

 Example 1:
 Input: weights = [1,2,3,4,5,6,7,8,9,10], D = 5
 Output: 15
 Explanation:
 A ship capacity of 15 is the minimum to ship all the packages in 5 days like this:
 1st day: 1, 2, 3, 4, 5
 2nd day: 6, 7
 3rd day: 8
 4th day: 9
 5th day: 10

 Note that the cargo must be shipped in the order given, so using a ship of capacity 14 and
 splitting the packages into parts like (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) is not allowed.
 */

class Solution {
    /**
     Binary search on the answer. The left boundary is max(weights), right boundary is
     sum(weights). We run binary search to find the minimum weight capacity of the ship.
     */
    func shipWithinDays(_ weights: [Int], _ D: Int) -> Int {
        // The lowest bound is the max of all the weights, because the ship needs to able
        // to carry the highest weight on a given day
        var low = weights.max() ?? 0
        var high = weights.reduce(0, +)

        while low < high {
            let potentialCapacity = (high + low) / 2

            print(potentialCapacity)

            if requiredDays(potentialCapacity, weights) >= D {
                low = potentialCapacity + 1
            } else {
                high = potentialCapacity
            }
        }

        return low
    }

    func requiredDays(_ maxCapacity: Int, _ weights: [Int]) -> Int {
        var days = 0
        var capacity = 0

        for w in weights {
            capacity += w

            if capacity > maxCapacity {
                capacity = w
                days += 1
            }
        }

        print("requiredDays:",days)

        return days
    }
}

print(Solution().shipWithinDays([3,2,2,4,1,4], 3))
