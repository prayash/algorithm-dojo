/**
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
 For example, two is written as II in Roman numeral, just two one's added together.
 Twelve is written as, XII, which is simply X + II. The number twenty seven is
 written as XXVII, which is XX + V + II.
 O(n) time and O(n) space.
 */

class Solution {
    func romanToInt(_ s: String) -> Int {
        let numerals: [Character: Int] = [
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000
        ]

        let arr = Array(s)
        var sum = 0

        for i in 0..<arr.count - 1 {
            let currentValue = numerals[arr[i]]!
            let nextValue = numerals[arr[i + 1]]!

            sum = sum + (currentValue < nextValue ? -currentValue : currentValue)
        }

        sum += numerals[arr.last!]!

        return sum
    }
}

print(Solution().romanToInt("IV"))
