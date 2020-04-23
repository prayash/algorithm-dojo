/**
 There is a special keyboard with all keys in a single row.
 Given a string keyboard of length 26 indicating the layout of the keyboard (indexed from 0 to 25),
 initially your finger is at index 0. To type a character, you have to move your finger to the index
 of the desired character. The time taken to move your finger from index i to index j is |i - j|.

 You want to type a string word.
 Write a function to calculate how much time it takes to type it with one finger.

 Input: keyboard = "abcdefghijklmnopqrstuvwxyz", word = "cba"
 Output: 4
 */

class Solution {
    // O(n) time and O(1) space
    func calculateTime(_ keyboard: String, _ word: String) -> Int {
        var moves = 0
        var position = 0
        var charTable: [String.Element : Int] = [:]

        // Generate a map of characters in the keyboard with indices for O(1) index access
        for (index, char) in keyboard.enumerated() {
            charTable[char] = index
        }

        for char in Array(word) {
            let positionOnKeyboard = charTable[char]!
            let distance = abs(position - positionOnKeyboard)

            moves += distance
            position = positionOnKeyboard
        }

        return moves
    }
}

print(Solution().calculateTime("abcdefghijklmnopqrstuvwxyz", "cba"))
print(Solution().calculateTime("pqrstuvwxyzabcdefghijklmno", "leetcode"))
