/**
 Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -.

 Input: a = 1, b = 2
 Output: 3

 Input: a = -2, b = 3
 Output: 1
 */

class Solution {
    /**
     Use XOR to add the numbers, AND to get the carry value.
     This is how addition is done in circuits.
     O(1) space. O(32) or O(1) time because at worse we'll go through all 32-bits.
     */
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        var carry = 0

        while b != 0 {
            // AND the two numbers to get the position of the potential carry bit.
            carry = a & b

            // XOR a and b to add the numbers
            // Since we lose the carry here, we've already pulled it out up there
            a = a ^ b

            // Re-assign carry because we will keep shifting and eventually
            // turn it into 0 while processing carry-over bits
            // Shift it to the left by 1 because the carry always gets added to the left of it
            b = carry << 1
        }

        return a
    }

    func getSumRecursively(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }

        let sum = a ^ b
        let carry = (a & b) << 1

        return getSumRecursively(sum, carry)
    }
}

print(Solution().getSum(2, 3))
print(Solution().getSum(200, 220))
print(Solution().getSum(-2, 3))

print(Solution().getSumRecursively(2, 3))
print(Solution().getSumRecursively(200, 220))
print(Solution().getSumRecursively(-2, 3))
