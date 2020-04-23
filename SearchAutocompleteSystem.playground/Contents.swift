/**
 Design a search autocomplete system for a search engine. Users may input a sentence (at least one word and end with a special character '#'). For each character they type except '#', you need to return the top 3 historical hot sentences that have prefix the same as the part of sentence already typed. Here are the specific rules:

 The hot degree for a sentence is defined as the number of times a user typed the exactly same sentence before.
 The returned top 3 hot sentences should be sorted by hot degree (The first is the hottest one). If several sentences have the same degree of hot, you need to use ASCII-code order (smaller one appears first).
 If less than 3 hot sentences exist, then just return as many as you can.
 When the input is a special character, it means the sentence ends, and in this case, you need to return an empty list.
 Your job is to implement the following functions:

 The constructor function:

 AutocompleteSystem(String[] sentences, int[] times): This is the constructor. The input is historical data. Sentences is a string array consists of previously typed sentences. Times is the corresponding times a sentence has been typed. Your system should record these historical data.

 Now, the user wants to input a new sentence. The following function will provide the next character the user types:

 List<String> input(char c): The input c is the next character typed by the user. The character will only be lower-case letters ('a' to 'z'), blank space (' ') or a special character ('#'). Also, the previously typed sentence should be recorded in your system. The output will be the top 3 historical hot sentences that have prefix the same as the part of sentence already typed.


 Example:
 Operation: AutocompleteSystem(["i love you", "island","ironman", "i love leetcode"], [5,3,2,2])
 The system have already tracked down the following sentences and their corresponding times:
 "i love you" : 5 times
 "island" : 3 times
 "ironman" : 2 times
 "i love leetcode" : 2 times
 */

class AutocompleteSystem {

    class Node {
        var children: [Character: Node] = [:]
        var list: [String: Int] = [:]
    }

    var root: Node
    var searchNode: Node?
    var lastInput: String = ""

    init(_ sentences: [String], _ times: [Int]) {
        root = Node()
        searchNode = root

        for i in 0..<sentences.count {
            add(sentences[i], times[i])
        }
    }

    func add(_ sentence: String, _ t: Int) {
        var current = root

        for char in sentence {
            if current.children[char] == nil {
                current.children[char] = Node()
            }

            if let childNode = current.children[char] {
                childNode.list[sentence, default: 0] += t
                current = childNode
            }
        }
    }

    func input(_ c: Character) -> [String] {
        var result = [String]()

        if c == "#" {
            add(lastInput, 1)
            searchNode = root
            lastInput = ""
        } else {
            lastInput.append(c)
            guard searchNode != nil else {
                return result
            }

            if let next = searchNode!.children[c] {
                let countList = next.list.sorted { lhs, rhs -> Bool in
                    let (string0, value0) = lhs
                    let (string1, value1) = rhs
                    return value0 > value1 || (value0 == value1 && string0 < string1)
                }

                // Return at most number of results
                var i = 0
                for (str, _) in countList {
                    i += 1
                    result.append(str)
                    if i == 3 {
                        break
                    }
                }

                searchNode = next
                return result
            } else {
                searchNode = nil
            }
        }

        return result
    }
}

/**
 * Your AutocompleteSystem object will be instantiated and called as such:
 * let obj = AutocompleteSystem(sentences, times)
 * let ret_1: [String] = obj.input(c)
 */

let sentences = ["i love you", "island", "ironman", "i love code"]
let times = [5, 3, 2, 2]
let acs = AutocompleteSystem(sentences, times)

print("Inputting 'i' returns: \(acs.input("i"))")
print("Inputting ' ' returns: \(acs.input(" "))")
print("Inputting 'a' returns: \(acs.input("a"))")
