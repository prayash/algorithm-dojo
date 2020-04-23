/**
 Given a time represented in the format "HH:MM", form the next closest time by reusing the current digits.
 There is no limit on how many times a digit can be reused.

 You may assume the given input string is always valid.
 For example, "01:34", "12:09" are all valid. "1:34", "12:9" are all invalid.

 This solution takes O(n) and O(n) space where n is the number of characters in the input.
 */

class Solution {
    func nextClosestTime(_ time: String) -> String {
        // Convert input into an array of Characters
        let timeValues = Array(time)

        // Copy over for final result
        var result = timeValues

        // Sort the digits into a bucket of valid numbers to check against
        let sortedDigits = [timeValues[0], timeValues[1], timeValues[3], timeValues[4]].sorted()

        // Increment + validate for HH:M_
        result[4] = increment(result[4], within: sortedDigits, limit: "9")
        if result[4] > timeValues[4] {
            return String(result)
        }

        // Increment + validate for HH:_M
        result[3] = increment(result[3], within: sortedDigits, limit: "5")
        if result[3] > timeValues[3] {
            return String(result)
        }

        // Increment + validate for H_:MM, limit depending on the preceeding digit
        result[1] = result[0] == "2"
            ? increment(result[1], within: sortedDigits, limit: "3")
            : increment(result[1], within: sortedDigits, limit: "9")

        if result[1] > timeValues[1] {
            return String(result)
        }

        // Increment + validate for _H:MM
        result[0] = increment(result[0], within: sortedDigits, limit: "2")
        return String(result)
    }

    private func increment(_ currVal: Character, within sortedDigits: [Character], limit: Character) -> Character {
        // If the digit we want to increment is already at the limit, then jump to the next lowest number
        if currVal == limit {
            return sortedDigits[0]
        }

        // Scan through the collection of valid numbers and extrac the one that fulfills our need
        for digit in sortedDigits {
            if digit > currVal, digit <= limit {
                return digit
            }
        }

        return sortedDigits[0]
    }
}

//print(Solution().nextClosestTime("19:34"))
//print(Solution().nextClosestTime("23:59"))
print(Solution().nextClosestTime("13:55"))
