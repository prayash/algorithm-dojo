/**
 A sentence S is given, composed of words separated by spaces. Each word consists of lowercase
 and uppercase letters only. We would like to convert the sentence to "Goat Latin" (a made-up
 language similar to Pig Latin.)

 The rules of Goat Latin are as follows:
 If a word begins with a vowel (a, e, i, o, or u), append "ma" to the end of the word.
 For example, the word 'apple' becomes 'applema'.

 If a word begins with a consonant (i.e. not a vowel), remove the first letter and append it
 to the end, then add "ma".
 For example, the word "goat" becomes "oatgma".

 Add one letter 'a' to the end of each word per its word index in the sentence, starting with 1.
 For example, the first word gets "a" added to the end, the second word gets "aa" added to the end and so on.
 Return the final sentence representing the conversion from S to Goat Latin.
 */
class Solution {
    /**
     Single pass string transformation.
     - Complexity: O(n) time and space
     */
    func toGoatLatin(_ S: String) -> String {
        var s = S.split(separator: " ")
        let vowels = Set<String>(["a", "e", "i", "o", "u"])

        for i in 0..<s.count {
            if let firstLetter = s[i].first {
                if vowels.contains(firstLetter.lowercased()) {
                    s[i] += "ma"
                } else {
                    let substringRange = s[i].index(s[i].startIndex, offsetBy: 1)..<s[i].endIndex

                    s[i] = s[i][substringRange]
                    s[i] += "\(firstLetter)ma"
                }

                s[i] += String(repeating: "a", count: i + 1)
            }
        }

        return s.joined(separator: " ")
    }
}

print(Solution().toGoatLatin("I speak Goat Latin"))
print(Solution().toGoatLatin("The quick brown fox jumped over the lazy dog"))
