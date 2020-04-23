/**
 Given a string, find the longest substring which contains 2 unique characters.
 */

class Solution {
    func findLongestSubstringWithTwoChars(input: String) -> String {
        var currentSubstring: String?
        var longestSubString = ""
        var firstLetter: String?
        var secondLetter: String?
        let letterArray = input.map { String($0) }

        for letter in letterArray {
            if let cur = currentSubstring {
                if let first = firstLetter, let second = secondLetter {
                    if letter == first || letter == second {
                        currentSubstring = cur + letter
                    } else {
                        if longestSubString.count < cur.count {
                            longestSubString = cur
                        }

                        firstLetter = second
                        secondLetter = letter
                        currentSubstring = firstLetter! + secondLetter!
                    }
                } else if let first = firstLetter {
                    if first == letter {
                        currentSubstring = cur + first
                    } else {
                        secondLetter = letter
                    }
                }
            } else {
                currentSubstring = letter
                firstLetter = letter
            }
        }

        if let cur = currentSubstring, longestSubString.count < cur.count {
            longestSubString = cur
        }

        return longestSubString
    }

}

print(Solution().findLongestSubstringWithTwoChars(input: "abcbbbbcccbdddadacb"))
