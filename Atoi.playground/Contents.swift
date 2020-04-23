/**
 Implement atoi which converts a string to an integer.

 The function first discards as many whitespace characters as necessary until the
 first non-whitespace character is found. Then, starting from this character, takes
 an optional initial plus or minus sign followed by as many numerical digits as
 possible, and interprets them as a numerical value.

 The string can contain additional characters after those that form the integral
 number, which are ignored and have no effect on the behavior of this function.

 If the first sequence of non-whitespace characters in str is not a valid integral
 number, or if no such sequence exists because either str is empty or it contains
 only whitespace characters, no conversion is performed.

 If no valid conversion could be performed, a zero value is returned.

 Note:
 Only the space character ' ' is considered as whitespace character.
 Assume we are dealing with an environment which could only store integers within
 the 32-bit signed integer range: [−2^31,  2^31 − 1]. If the numerical value is out of
 the range of representable values, Int.max (2^31 − 1) or Int.min (−2^31) is returned.
 */

let ASCII_OFFSET = 48

class Solution {
    func atoi(_ str: String) -> Int {
        var sign = 1
        var result = 0
        var hasProcessedFirstDigit = false

        for char in str {
            // Omit spaces at the front
            if char == " " && !hasProcessedFirstDigit {
                continue
            }

            // Get the sign modifier
            if (char == "-" || char == "+") && !hasProcessedFirstDigit {
                sign = char == "-" ? -1 : 1
                hasProcessedFirstDigit = true
                continue
            }

            // Convert the actual numbers, being mindful of Integer bounds
            if char <= "9" && char >= "0", let asciiValue = char.asciiValue {
                let numericVal = Int(asciiValue) - ASCII_OFFSET

                result = (abs(result * 10) + numericVal) * sign

                if result > Int32.max {
                    result = Int(Int32.max)
                } else if result < Int32.min {
                    result = Int(Int32.min)
                }

                hasProcessedFirstDigit = true
            } else {
                return result
            }
        }

        return result
    }

    func atoiRecursive(_ str: String) -> Int {
        func helper(_ str: String, _ index: Int) -> Int {
            if index == 1 {
                return Int(str[0])!
            }

            return 10 * helper(str, index - 1) + Int(str[index - 1])!
        }

        return helper(str, str.count)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

var input = "42"
print(Solution().atoi(input)) // 42

input = "   -42"
print(Solution().atoi(input)) // -42

input = "4193 with words"
print(Solution().atoi(input)) // 4193

input = "words and 987"
print(Solution().atoi(input)) // 0

input = "-91283472332"
print(Solution().atoi(input)) // -2147483648

print("\nASCII Encodings")
for ch in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] as [Character] {
    print(ch, "-->", ch.asciiValue!)
}

print(Solution().atoiRecursive("42069"))

for ch in ["a"] as [Character] {
    print(ch, "-->", ch.asciiValue!)
}
