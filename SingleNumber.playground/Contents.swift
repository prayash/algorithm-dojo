/**
 Given a non-empty array of integers, every element appears twice except for one. Find that single one.
 Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

 Input: [2, 2, 1]
 Output: 1

 Input: [4, 1, 2, 1, 2]
 Output: 4
 */

class Solution {
    /**
     Seveeral ways to do this one. Worst approach would be a nested loop that uses an extra array
     to keep track of duplicates. This would be O(n ^ 2) time. That's terrible. A more sane approach
     is to use a Set, and insert/remove when we see a digit. The last remaining number would be the return
     value, like so. But this takes O(n) time and space.
     */
    func singleNumberUsingSet(_ nums: [Int]) -> Int {
        var set = Set<Int>()

        for number in nums {
            if set.contains(number) {
                set.remove(number)
            } else {
                set.insert(number)
            }
        }

        return set.first!
    }

    /**
     The best way to do this is to by bit manipulation. Taking XOR of 0 and some bit, we get
     all the set bits back. Taking XOR of two of the same bits, we get 0. If we XOR all
     the bits together, the only remaining bit will be the unique number. This takes O(n) time
     and O(1) space!
     */
    func singleNumber(_ nums: [Int]) -> Int {
        var a = 0

        for number in nums {
            a = a ^ number
        }

        return a
    }
}

print(Solution().singleNumber([4, 1, 2, 1, 2]))
