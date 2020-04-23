/**
 You're given strings J representing the types of stones that are jewels, and S representing the
 stones you have.  Each character in S is a type of stone you have.  You want to know how many of the
 stones you have are also jewels.

 The letters in J are guaranteed distinct, and all characters in J and S are letters.
 Letters are case sensitive, so "a" is considered a different type of stone from "A".

     Input: J = "aA", S = "aAAbbbb" Output: 3
     Input: J = "z", S = "ZZ" Output: 0

 S and J will consist of letters and have length at most 50.
 The characters in J are distinct.
 */

class Solution {
    /**
     O(J + S) because we have to take a single pass through both of them.
     O(J) for storing a hash table of its chars.
     */
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var jewelCharMap: [String : Int] = [:]
        var jewelCount = 0

        // Build the jewel dictionary
        for char in J {
            jewelCharMap[String(char)] = 0
        }

        // Scan the input string, counting each char
        for char in S {
            let c = String(char)

            if jewelCharMap[c] != nil {
                jewelCount += 1
            }
        }

        // Return summation
        return jewelCount
    }
}

var J = "aA"
var S = "aAAbbbb"
print(Solution().numJewelsInStones(J, S))

J = "z"
S = "ZZ"
print(Solution().numJewelsInStones(J, S))
