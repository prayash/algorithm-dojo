class TrieNode {
    var children: [Character : TrieNode] = [:]

    func hasChildNode(for character: Character) -> Bool {
        return children[character] != nil
    }

    func makeChildNode(for character: Character) {
        children[character] = TrieNode()
    }

    func getChildNode(for character: Character) -> TrieNode? {
        return children[character]
    }
}

class Trie {
    let root = TrieNode()
    private var endOfWordMarker: Character = "\0"

    func addWord(_ word: String) -> Bool {
        var currentNode = root
        var isNewWord = false

        // Work downwards through the trie, adding nodes
        // as needed, and keeping track of whether we add any nodes.
        for character in word {
            if !currentNode.hasChildNode(for: character) {
                isNewWord = true
                currentNode.makeChildNode(for: character)
            }

            if let childNode = currentNode.getChildNode(for: character) {
                currentNode = childNode
            }
        }

        // Explicitly mark the end of a word. Otherwise, we might say a word is
        // present if it is a prefix of a different, longer word that was added earlier.
        if !currentNode.hasChildNode(for: endOfWordMarker) {
            isNewWord = true
            currentNode.makeChildNode(for: endOfWordMarker)
        }

        return isNewWord
    }

    func hasWord(_ s: String) -> Bool {
        var node = root

        for character in s {
            if !node.hasChildNode(for: character) {
                return false
            }

            if let childNode = node.getChildNode(for: character) {
                node = childNode
            }
        }

        return true
    }
}

let trie = Trie()
let helloWorld = "helloworld"

trie.addWord("hello")
trie.addWord(helloWorld)

print(trie.hasWord(helloWorld))
print(trie.hasWord("123"))
