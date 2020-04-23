/**
 Implement function ToLowerCase() that has a string parameter str, and returns the same string in lowercase.
 Input: "Hello" Output: "hello"
 */

class Solution {
    func toLowerCase(_ str: String) -> String {
        var res: String = ""

        for char in str {
            let upperCaseRange = Character("A").asciiValue!...Character("Z").asciiValue!

            guard var aVal = Character(String(char)).asciiValue else {
                return res
            }

            if upperCaseRange ~= aVal {
                aVal += 32
            }

            res += String(UnicodeScalar(aVal))
        }

        return res
    }
}

print(Solution().toLowerCase("CODEZZZ"))
print(Solution().toLowerCase("Hello"))
