/**
 Design a data structure that supports the following two operations:

     void addWord(word)
     bool search(word)

 search(word) can search a literal word or a regular expression string containing only
 letters a-z or .. A . means it can represent any one letter. Example:

     addWord("bad")
     addWord("dad")
     addWord("mad")
     search("pad") -> false
     search("bad") -> true
     search(".ad") -> true
     search("b..") -> true

 Note: You may assume that all words are consist of lowercase letters a-z.
 */

class WordDictionary {
    class Node {
        var children: [Character: Node] = [:]
        var isTerminal: Bool = false
    }

    var root: Node

    init() {
        root = Node()
    }

    /**
     Adds a word into the data structure.
     */
    func addWord(_ word: String) {
        var current = root

        for char in word {
            if let childNode = current.children[char] {
                current = childNode
            } else {
                current.children[char] = Node()
                current = current.children[char]!
            }
        }

        current.isTerminal = true
    }

    /**
     Returns if the word is in the data structure.
     A word could contain the dot character '.' to represent any one letter.
     */
    func search(_ word: String) -> Bool {
        func match(_ word: String, _ i: Int, _ node: Node) -> Bool {
            if i == word.count {
                return node.isTerminal
            }

            if word[i] == "." {
                for (_, key) in node.children.keys.enumerated() {
                    if let child = node.children[key], match(word, i + 1, child) {
                        return true
                    }
                }
            } else if let childNode = node.children[word[i]] {
                return match(word, i + 1, childNode)
            }

            return false
        }

        return match(word, 0, root)
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */

let wd = WordDictionary()
wd.addWord("bad")
wd.addWord("dad")
wd.addWord("mad")
wd.search("pad")    // false
wd.search("bad")    // true
wd.search(".ad")    // true
wd.search("b..")    // true
