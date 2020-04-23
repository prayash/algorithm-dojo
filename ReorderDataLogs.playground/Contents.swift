/**
 You have an array of logs.  Each log is a space delimited string of words.

 For each log, the first word in each log is an alphanumeric identifier.  Then, either:
 Each word after the identifier will consist only of lowercase letters, or;
 Each word after the identifier will consist only of digits.
 We will call these two varieties of logs letter-logs and digit-logs.
 It is guaranteed that each log has at least one word after its identifier.

 Reorder the logs so that all of the letter-logs come before any digit-log.
 The letter-logs are ordered lexicographically ignoring identifier, with the identifier
 used in case of ties. The digit-logs should be put in their original order.

 Return the final order of the logs.
 */

class Solution {
    func reorderLogFiles(_ logs: [String]) -> [String] {
        guard logs.count != 0 else { return [] }

        // directly store digit Strings in order, since we do not need to change order
        var orderedDigits = [String](), orderedLetters = [String]()

        // store letter log with (id, value) format in an array
        // eg "a1 9 2 3 1" => ("a1", "9 2 3 1")
        // we cannot use dictionary here since it may occur same key with different value cases
        var letters = [(String, String)]()

        for log in logs {
            let spaceIndex = log.firstIndex(of: " ")!
            let startValueIndex = log.index(after: spaceIndex)
            let key = String(log[..<spaceIndex])
            let value = String(log[startValueIndex...])

            if value.first!.isLetter {
                letters.append((key, value)) // when letter log case
            } else {
                orderedDigits.append(log) // when digit log case, directly store digit case in order
            }
        }

        // only letter-logs's values(ignore id) need to be ordered lexicographically
        letters.sort(by: { $0.1 <= $1.1 })

        // eg: (a,b).0 is equal to a; (a,b).1 is equal to b
        for letter in letters { orderedLetters.append(letter.0 + " " + letter.1) }

        return orderedLetters + orderedDigits
    }
}

let logs = ["dig1 8 1 5 1","let1 art can","dig2 3 6","let2 own kit dig","let3 art zero"]
print(Solution().reorderLogFiles(logs))
