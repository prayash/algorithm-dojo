/**
 Write a function that reverses a string. The input string is given as an array of characters.
 Do not allocate extra space for another array, you must do this by modifying the input
 array in-place with O(1) extra memory.

 Input: ["h","e","l","l","o"]
 Output: ["o","l","l","e","h"]
 */

class Solution {
    /**
     Two-pointer method
     O(n/2) time because the input gets halved and does n/2 swaps.
     and O(1) space because it's in place.
     */
    func reverseString(_ str: inout [Character]) {
        guard str.count > 1 else {
            return
        }

        var leftPtr = 0, rightPtr = str.count - 1

        while leftPtr < rightPtr {
            defer {
                leftPtr += 1
                rightPtr -= 1
            }

            str.swapAt(leftPtr, rightPtr)
        }
    }

    func reverse(_ str: inout String) {
        guard str.count > 0 else { return }

        var leftIndex = str.startIndex
        var rightIndex = str.index(before: str.endIndex)

        while leftIndex < rightIndex {
            // Swap characters
            let left = str[leftIndex]
            let right = str[rightIndex]

            str.replaceSubrange(leftIndex...leftIndex, with: String(right))
            str.replaceSubrange(rightIndex...rightIndex, with: String(left))

            leftIndex = str.index(after: leftIndex)
            rightIndex = str.index(before: rightIndex)
        }
    }
}

var input = ["h", "e", "l", "l", "o"].map { Character(UnicodeScalar($0)) }
Solution().reverseString(&input)

print(String(input))

var word = "racecar"
Solution().reverse(&word)
print(word)
