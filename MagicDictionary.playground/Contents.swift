/**
 Implement a magic directory with buildDict, and search methods.
 For the method buildDict, you'll be given a list of non-repetitive words to build a dictionary.

 For the method search, you'll be given a word, and judge whether if you modify exactly
 one character into another character in this word, the modified word is in the dictionary
 you just built.

     Input: buildDict(["hello", "leetcode"]), Output: Null
     Input: search("hello"), Output: False
     Input: search("hhllo"), Output: True
     Input: search("hell"), Output: False
     Input: search("leetcoded"), Output: False

 Note: You may assume that all the inputs are consist of lowercase letters a-z.
 */

class MagicDictionary {
    var map = [Int: Set<String>]()

    /** Initialize your data structure here. */
    init() {

    }

    /** Build a dictionary through a list of words */
    func buildDict(_ dict: [String]) {
        map.removeAll()
        for str in dict {
            var sets = map[str.count, default: Set<String>()]
            sets.insert(str)
            map[str.count] = sets
        }
    }

    /** Returns if there is any word in the trie that equals to the given word after modifying exactly one character */
    func search(_ word: String) -> Bool {
        let sets = map[word.count, default: Set<String>()]

        for str in sets {
            var diffCount = 0

            for i in 0..<word.count {
                if word[i] != str[i] {
                    diffCount += 1
                }

                if diffCount > 1 {
                    break
                }
            }

            if diffCount == 1 {
                return true
            }
        }
        return false
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

/**
 * Your MagicDictionary object will be instantiated and called as such:
 * let obj = MagicDictionary()
 * obj.buildDict(dict)
 * let ret_2: Bool = obj.search(word)
 */

let md = MagicDictionary()
md.buildDict(["hello", "deadbeef"])
md.search("hello")          // false
md.search("hhllo")          // true
md.search("hell")           // false
md.search("deadbeefed")     // false
md.search("deadbeet")       // true
