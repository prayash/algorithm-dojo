/**
 Implement a trie with insert, search, and startsWith methods.

     let trie = Trie();

     trie.insert("apple");
     trie.search("apple");   // returns true
     trie.search("app");     // returns false
     trie.startsWith("app"); // returns true
     trie.insert("app");
     trie.search("app");     // returns true

 Note:
 You may assume that all inputs are consist of lowercase letters a-z.
 All inputs are guaranteed to be non-empty strings.
 */

class Trie {

    private var root: TrieNode

    init() {
        self.root = TrieNode()
    }

    /**
     Inserts a word into the trie. We insert by searching into the trie.
     Starting from the root, we'll traverse the word character-wise. It a link
     exists, we'll move down the tree following the link to the next character.
     - Complexity: O(m) where m is the key length. O(m) space, because we may have to add m
     nodes if none of the links exist.
     */
    func insert(_ word: String) {
        guard !word.isEmpty else { return }

        var current = root
        for letter in word {
            if let child = current.children[letter] {
                current = child
            } else {
                current.children[letter] = TrieNode()
                current = current.children[letter]!
            }
        }

        current.isTerminal = true
    }

    /**
     Returns if the word is in the trie. Each key is represented in the trie as a path from
     the root to the internal node or leaf. Starting from the root, we'll move down the tree.
     If a link eixsts, we'll keep traversing, otherwise we return false.
     - Complexity: O(m) because at each step we search for the next key character. O(1) space.
     */
    func search(_ word: String) -> Bool {
        var current = self.root
        for letter in word {
            if let currentNode = current.children[letter] {
                current = currentNode
            } else {
                return false
            }
        }

        return current.isTerminal
    }

    /**
     Returns if there is any word in the trie that starts with the given prefix.
     Very similar to the `search` routine. We traverse the tree from the root until
     there are no characters left in the key prefix or it is impossible to continue the path.
     The only difference is we don't need to consider whether the ending node is a leaf or not
     since this is just searching for a prefix and not a whole word!
     - Complexity: O(m) for length of the prefix. O(1) space.
     */
    func startsWith(_ prefix: String) -> Bool {
        var current = self.root
        for letter in prefix {
            if let currentNode = current.children[letter] {
                current = currentNode
            } else {
                return false
            }
        }

        return true
    }
}

class TrieNode {
    var children: [Character: TrieNode] = [:]

    /// Maximum of 26 links to its children, each link corresponds to chars from the alphabet
    let maxLinks: Int = 26

    /// Boolean to specify whether it's the end of the key, or just a key prefix
    var isTerminal: Bool = false

    init() {
        self.children = [Character: TrieNode]()
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */

let t = Trie()
t.insert("apple")
t.search("apple")   // true
t.search("app")     // false
t.startsWith("app") // true
