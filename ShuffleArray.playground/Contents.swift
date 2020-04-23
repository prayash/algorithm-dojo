/**
 Shuffle a set of numbers without duplicates.

 Example:

     // Init an array with set 1, 2, and 3.
     int[] nums = {1,2,3};
     Solution solution = new Solution(nums);

     // Shuffle the array [1,2,3] and return its result.
     // Any permutation of [1,2,3] must equally
     likely to be returned.
     solution.shuffle();

     // Resets the array back to its original configuration [1,2,3].
     solution.reset();

     // Returns the random shuffling of array [1,2,3].
     solution.shuffle();
 */

class Solution {

    let array: [Int]

    init(_ nums: [Int]) {
        self.array = nums
    }

    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return array
    }

    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        var copy = array
        var length = copy.count
        
        for _ in copy {
            let randomIndex = Int.random(in: 0..<length)
            if randomIndex != length - 1 {
                copy.swapAt(randomIndex, length - 1)
            }

            length -= 1
        }

        return copy
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */

