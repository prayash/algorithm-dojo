/**
 Koko loves to eat bananas.  There are N piles of bananas, the i-th pile has piles[i] bananas.
 The guards have gone and will come back in H hours.

 Koko can decide her bananas-per-hour eating speed of K.  Each hour, she chooses some pile
 of bananas, and eats K bananas from that pile.  If the pile has less than K bananas, she
 eats all of them instead, and won't eat any more bananas during this hour.

 Koko likes to eat slowly, but still wants to finish eating all the bananas before the
 guards come back.

 Return the minimum integer K such that she can eat all the bananas within H hours.

 Example 1:

 Input: piles = [3,6,7,11], H = 8
 Output: 4
 */

class Solution {
    /**
     Each hour, Koko chooses some pile of bananas, and eats K bananas from that pile.
     There is a limited range of K's to enable her to eat all the bananas within H hours.
     We ought to reduce the searching space and to return the minimum valid K.
     Binary Search is born for that.
     Initially, we know that K belongs to [1, the largest element in piles[]].
     And we follow the pattern of lower-bound Binary Search except that if (K == target)
     is replaced with if (canEatAll(piles, K, H)).
     */
    func minEatingSpeed(_ piles: [Int], _ H: Int) -> Int {
        var low = 0
        var high = piles.max()!

        while low <= high {
            let mid = low + (high - low) / 2

            if canEatAllPiles(piles, H, K: mid) {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }

        return low
    }

    func canEatAllPiles(_ piles: [Int], _ H: Int, K: Int) -> Bool {
        var hours = 0

        for pile in piles {
            hours += pile / K

            if pile % K != 0 {
                hours += 1
            }
        }

        return hours <= H
    }
}

print(Solution().minEatingSpeed([3,6,7,11], 8))
