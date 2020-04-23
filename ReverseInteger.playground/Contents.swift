/**
 Given a 32-bit signed integer, reverse digits of an integer.
 Input: 123
 Output: 321
 */

class Solution {
    /**
     Iteratively modulo by 10 to pop off the last digit and push onto new value.
     - Complexity: O(log n) were n is the input number. O(1) space.
     */
    func reverseInteger(_ x: Int) -> Int {
        var x = x
        var reversed = 0

        while x != 0 {
            // Pop the last digit off by modulo 10
            let pop = x % 10

            // Reduce the number since we just popped
            x = x / 10

            if reversed > 0 && reversed > Int32.max / 10 {
                return 0
            }

            if reversed < 0 && reversed < Int32.min / 10 {
                return 0
            }

            // Tack on the number into our return value
            reversed = reversed * 10 + pop
        }

        return reversed
    }
}

print(Solution().reverseInteger(123)) // 321
print(Solution().reverseInteger(1463847412)) // 2147483641
print(Solution().reverseInteger(1534236469)) // 0

print("Int 32 max: \(Int32.max)")
print("Int 32 min: \(Int32.min)")
