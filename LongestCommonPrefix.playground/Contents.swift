// O(n) where n is the sum of all characters in all strings
func longestCommonPrefix(_ strs: [String]) -> String {
    guard strs.count > 0 else { return "" }

    let shortestWord = strs.min { $0.count < $1.count }!
    var longestPrefix = shortestWord

    for word in strs {
        while !word.hasPrefix(longestPrefix), longestPrefix.count > 0 {
            longestPrefix.removeLast()
        }
    }

    return longestPrefix
}

let x = ["flower", "flow", "flight"]
print(longestCommonPrefix(x))
