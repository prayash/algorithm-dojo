/**
 Given two binary strings, return their sum (also a binary string).
 The input strings are both non-empty and contains only characters 1 or 0.

 Input: a = "11", b = "1"
 Output: "100"

 Input: a = "1010", b = "1011"
 Output: "10101"
 */

class Solution {
    /**
     Classical method would be to convert a and b into integers. Compute the sum, and then
     convert it back into binary form. This could be done with built-in functions.
     Another method is to use the bit-by-bit computation, where we do it elementary math style.
     Runtime: O(max(m, n)) where m and n are two input strings a and b
     */
    func addBinary(_ a: String, _ b: String) -> String {
        var carry: Int = 0
        var result: String = ""

        // Turn them into Int arrays
        var a: [Int] = a.map { Int(String($0))! }
        var b: [Int] = b.map { Int(String($0))! }

        // Ensure that the two arrays are of same length
        while a.count != b.count {
            if a.count > b.count {
                b.insert(Int(String(0))!, at: 0)
            } else {
                a.insert(Int(String(0))!, at: 0)
            }
        }

        // Loop through both collections starting at the end
        var index = a.count - 1
        while index >= 0 {
            // Add the two numbers, factoring in the carry-over value
            let sum: Int = a[index] + b[index] + carry

            // Prepend the result (either 1 or 0) to itself
            result = "\(sum % 2)" + result

            // The carry can either be
            carry = sum / 2

            // Decrement to move up the array
            index -= 1
        }

        // Last thing left is to tack on the final carry value
        if carry != 0 {
            result = "1" + result
        }

        return result
    }
}

let a = "111"
let b = "101"

print(Solution().addBinary(a, b))
