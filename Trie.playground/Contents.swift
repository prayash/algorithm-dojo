class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    var isTerminating = false

    init(value: T? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }

    func add(child: T) {
        guard children[child] == nil else { return }

        children[child] = TrieNode(value: child, parent: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    private let root: Node

    init() {
        root = Node()
    }

    func insert(word: String) {
        guard !word.isEmpty else { return }

        var currentNode = root
        let characters = Array(word.lowercased())

        var i = 0
        while i < characters.count {
            let character = characters[i]

            // Check if the character we're trying to insert exists within the current
            // node's children dict. If it exists, we'll make the currentNode pointer
            // reference the next node. No need to insert, it's already there!
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                // Character needs to be inserted, so we'll add it to the children dict.
                // Move the currentNode pointer to the new node
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }

            i += 1
        }

        // If the current index equals the number of letters, that means it's
        // a terminating node. Let's mark that.
        if i == characters.count {
            currentNode.isTerminating = true
        }
    }

    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }

        var currentNode = root
        let characters = Array(word.lowercased())

        var i = 0
        while i < characters.count, let child = currentNode.children[characters[i]] {
            i += 1
            currentNode = child
        }

        return i == characters.count && currentNode.isTerminating
    }
}

let trie = Trie()

trie.insert(word: "cute")
trie.contains(word: "cute") // true

trie.contains(word: "cut") // false
trie.insert(word: "cut")
trie.contains(word: "cut") // true

trie.insert(word: "prayash")
trie.contains(word: "pray")
trie.insert(word: "pray")
trie.contains(word: "pray")
