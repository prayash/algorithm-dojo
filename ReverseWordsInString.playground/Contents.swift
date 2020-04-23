import Foundation

/**
 Given an input string, reverse the string word by word.

 Example 1:
 Input: "the sky is blue"
 Output: "blue is sky the"

 Example 2:
 Input: "  hello world!  "
 Output: "world! hello"
 Explanation: Your reversed string should not contain leading or trailing spaces.
 */
class Solution {
    private func trimSpaces(_ s: String) -> Array<Character> {
        var arr = [Character]()

        var i = 0, j = s.count - 1
        while i <= j && s[i] == " " {
            i += 1
        }

        while i <= j && s[j] == " " {
            j -= 1
        }

        while i <= j {
            if s[i] != " " {
                arr.append(s[i])
            } else if let lastChar = arr.last, lastChar != " " {
                arr.append(s[i])
            }

            i += 1
        }

        return arr
    }

    private func reverseString(_ s: inout Array<Character>, _ i: Int, _ j: Int) {
        var i = i
        var j = j
        while i < j {
            s.swapAt(i, j)

            i += 1
            j -= 1
        }
    }

    private func reverseEachWord(_ s: inout Array<Character>) {
        var i = 0, j = 0

        while i < s.count {
            while j < s.count && s[j] != " " {
                j += 1
            }

            reverseString(&s, i, j - 1)

            i = j + 1
            j += 1
        }
    }

    func reverseWords(_ s: String) -> String {
        var trimmedCollection = trimSpaces(s)
        reverseString(&trimmedCollection, 0, trimmedCollection.count - 1)
        reverseEachWord(&trimmedCollection)

        return String(trimmedCollection)
    }
}

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

func reverseWords(_ s: String) -> String {
    guard s.count > 0 else { return String() }

    let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
    let a = trimmed.split(separator: " ")
    var result = ""

    for i in stride(from: a.count - 1, through: 0, by: -1) {
        result += a[i] + " "
    }

    return result.trimmingCharacters(in: .whitespacesAndNewlines)
}

print(Solution().reverseWords("  swift       is        fun                 "))
