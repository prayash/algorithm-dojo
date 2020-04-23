/**
 Given a string containing digits from 2-9 inclusive, return all possible letter combinations
 that the number could represent.

 A mapping of digit to letters (just like on the telephone buttons) is given below. Note that
 1 does not map to any letters.

 Input: "23"
 Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
 */
class Solution {
    let mappings: [Int: String] = [
        2: "abc",
        3: "def",
        4: "ghi",
        5: "jkl",
        6: "mno",
        7: "pqrs",
        8: "tuv",
        9: "wxyz"
    ]

    /**
     O(3 ^ n * 4 ^ m) where n and m are the number of digits that map to letters
     */
    func letterCombinations(_ digits: String) -> [String] {
        guard digits.count > 0 else {
            return []
        }

        var result = [String]()
        let digits = digits.map { Int(String($0))! }

        calc(&result, digits, "", index: 0)
        return result
    }

    func calc(_ result: inout [String], _ digits: [Int], _ current: String, index: Int) {
        // No more digits to check, add the combo
        if index == digits.count {
            result.append(current)
            return
        }

        // Grab the set of characters for this digit
        let currentDigit = digits[index]
        let letters = mappings[currentDigit]!.map { String($0) }

        // Iterate over all letters which map the next available digit
        for i in 0..<letters.count {
            // Append the current letter to the combination and proceed to the next digits
            calc(&result, digits, current + String(letters[i]), index: index + 1)
        }
    }
}




class SolutionZ {
    let mappings: [Character: String] = [
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz"
    ]

    func letterCombinations(_ digits: String) -> [String] {
        var result = [String]()
        var digits = Array(digits)

        func calc(_ current: String, _ index: Int) {
            if index == digits.count {
                result.append(current)
                return
            }

            let number = digits[index]
            if let chars = mappings[number] {
                for c in chars {
                    calc(current + String(c), index + 1)
                }
            }
        }

        calc("", 0)
        return result
    }
}

print(SolutionZ().letterCombinations("23"))
























print(Solution().letterCombinations("23"))
