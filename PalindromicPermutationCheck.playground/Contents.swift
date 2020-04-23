class Solution {

    // MARK: - O(n) solution 😎

    /**
     Fastest approach is to use a Set, and keep track of all the letters we see
     an odd number of times. We'll know if it's a palindrome if there is 1 or 0
     characters left in the Set (in the case of a string with odd/even length).
     - Complexity: O(n) time and space.
     */
    func hasPalidromicPermutation(_ s: String) -> Bool {
        var charSet = Set<Character>()

        for char in s {
            if charSet.contains(char) {
                charSet.insert(char)
            } else {
                charSet.remove(char)
            }
        }

        // It's only a palindrome if it has one or zero characters without a pair
        return charSet.count <= 1
    }

    // MARK: - Brute force 🤮

    /**
     A brute force solution would be to generate all permutations of the input string
     and for each permutation check if its a palindrome. That's O(n!) for generating
     permutations and O(n) for validation.
     - Complexity: O(n! * n). No bueno.
     */
    func hasPalidromicPermutationNaive(_ s: String) -> Bool {
        let permutations = calculatePermutations(for: s)

        for permutation in permutations {
            if isPalindrome(permutation) {
                return true
            }
        }

        return false
    }

    private func calculatePermutations(for word: String) -> Set<String> {
        var set = Set<String>()
        permutation(for: word, set: &set)
        return set
    }

    private func permutation(for word: String, prefix: String = "", set: inout Set<String>) {
        if word.count == 0 {
            set.insert(prefix)
        }

        for i in word.indices {
            let left = String(word[..<i])
            let right = word[word.index(after: i)...]

            let remainder = left + right
            permutation(for: remainder, prefix: prefix + String(word[i]), set: &set)
        }
    }

    private func isPalindrome(_ s: String) -> Bool {
        guard s.count > 1 else { return true }

        let s = Array(s)
        for i in 0...s.count / 2 {
            if String(s[i]) != String(s[s.count - i - 1]) {
                return false
            }
        }

        return true
    }
}


var s = "racecar"
print(Solution().hasPalidromicPermutation(s))
print(Solution().hasPalidromicPermutationNaive(s))

