/**
 Given a string s, return all the palindromic permutations (without duplicates) of it. Return an empty list if no palindromic permutation could be form.

 Input: "aabb" Output: ["abba", "baab"]
 Input: "abc" Output: []
 */

class Solution {
    /**
     Brute force approach would be to generate all permutations and validate them as
     palindromes before returning the final collection.
     - Complexity: O(n!) time. A total of n!n! permutations are possible. O(n) space due to depth
     of the recursion tree.
     */
    func generatePalindromes(_ s: String) -> [String] {
        var charSet = Set<Character>()
        guard hasPalidromicPermutation(s, &charSet) else {
            return []
        }

        var outputSet = Set<String>()
        var candidate = [Character]()
        var visited = Array(repeating: false, count: s.count)

        permute(s, &outputSet, &candidate, &visited)

        return Array(outputSet)
    }

    func permute(_ s: String, _ set: inout Set<String>, _ candidates: inout [Character], _ visited: inout [Bool]) {
        // Abort once we reach a leaf
        if candidates.count == s.count && isPalindrome(candidates) {
            set.insert(String(candidates))
            return
        }

        for i in 0..<s.count where !visited[i] {
            // If we have a duplicate value that we haven't visited
            if i > 0 && s[i - 1] == s[i] && !visited[i - 1] {
                continue
            }

            candidates.append(s[i])
            visited[i] = true

            permute(s, &set, &candidates, &visited)

            candidates.removeLast()
            visited[i] = false
        }
    }

    func isPalindrome(_ s: [Character]) -> Bool {
        guard !s.isEmpty || s.count > 1 else { return true }
        let input = s

        var i = 0
        var j = input.count - 1

        while i < j {
            if input[i] != input[j] {
                return false
            }

            i += 1
            j -= 1
        }

        return true
    }

    func hasPalidromicPermutation(_ s: String, _ charSet: inout Set<Character>) -> Bool {
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
}

extension String {
  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
}

print(Solution().generatePalindromes("aabb"))
print(Solution().generatePalindromes("abc"))
