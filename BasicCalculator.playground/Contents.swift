/**
 Implement a basic calculator to evaluate a simple expression string.
 The expression string contains only non-negative integers, +, -, *, / operators
 and empty spaces. The integer division should truncate toward zero.

 Input: "3+2*2"
 Output: 7

 Input: " 3+5 / 2 "
 Output: 5
 */

class Solution {
    /**
     Use a stack to cache numbers.
     Calculate when char in "+-/" and sign == "/" first.
     Sum all numbers in the stack.
     */
    func calculate(_ s: String) -> Int {
        var stack = [Int]()
        var sign: Character = "+"
        var number = 0
        let s = s + "+"

        for char in s {
            let isOperator = "+-*/".contains(char)

            if isOperator {
                switch sign {
                case "+":
                    stack.append(number)
                case "-":
                    stack.append(-number)
                case "*":
                    stack[stack.count - 1] *= number
                case "/":
                    stack[stack.count - 1] /= number
                default:
                    continue
                }

                number = 0
                sign = char
            } else if " " != char {
                // Handle new decimal places and then add the value
                number = number * 10 + (char.wholeNumberValue ?? 0)
            }
        }

        return stack.reduce(0, +)
    }
}

print(Solution().calculate("3+2*2"))
print(Solution().calculate(" 3+5 / 2 "))
print(Solution().calculate("42"))

func uniqueStrings(_ s: [String]) -> Int {
    var set = Set<String>()

    for string in s {
        set.insert(string)
    }

    return set.count
}

uniqueStrings(["abc", "def", "abc", "def"])
