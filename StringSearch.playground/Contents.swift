extension String {
    func index(of pattern: String) -> Index? {
        for i in indices {
            var j = i
            var found = true

            for p in pattern.indices {
                guard j != endIndex && self[j] == pattern[p] else {
                    found = false
                    break
                }

                j = index(after: j)
            }

            if found {
                return i
            }
        }

        return nil
    }

    fileprivate var skipTable: [Character: Int] {
        var skipTable: [Character: Int] = [:]
        for (i, c) in enumerated() {
            skipTable[c] = count - i - 1
        }

        return skipTable
    }

    func bmIndex(of pattern: String) -> Index? {

        return nil
    }
}

let text = "Hello"
print(text.index(of: "lo")?.encodedOffset)
text.skipTable.forEach { print($0) }
