func naiveHash(_ string: String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { Int($0.value) }

    return unicodeScalars.reduce(0, +)
}

naiveHash("hello")
naiveHash("elohl") // Terrible, because any permutation yields a collision

// http://www.cse.yorku.ca/~oz/hash.html
// https://gist.github.com/kharrison/2355182ac03b481921073c5cf6d77a73#file-country-swift-L31
func djb2Hash(_ string: String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { Int($0.value) }

    return unicodeScalars.reduce(5381) {
        ($0 << 5) &+ $0 &+ Int($1)
    }
}

djb2Hash("hello")
djb2Hash("elohl")

print(djb2Hash("firstName"))

djb2Hash("firstName") % 2
djb2Hash("lastName") % 2

struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]

    private(set) public var count = 0
    var isEmpty: Bool {
        return count == 0
    }

    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }

    func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }

    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }

        set {
            if let value = newValue {
                update(value: value, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }

    func value(for key: Key) -> Value? {
        let index = self.index(for: key)

        return buckets[index].first { $0.key == key }?.value
    }

    @discardableResult
    mutating func update(value: Value, for key: Key) -> Value? {
        let index = self.index(for: key)

        // If the value is already inside a bucket, overwrite it
        if let (i, element) = buckets[index].enumerated().first(where: {
            $0.1.key == key
        }) {
            let oldValue = element.value

            buckets[index][i].value = value
            return oldValue
        }

        // If it doesn't map to a particular value inside the hash table
        // Add the new key-value pair at the end of the bucket
        buckets[index].append((key: key, value: value))
        count += 1

        return nil
    }

    @discardableResult
    mutating func removeValue(for key: Key) -> Value? {
        let index = self.index(for: key)

        // Check to see if the value is in the bucket, and remove the key in
        // the chain, decrement the count, and return that value
        if let (i, element) = buckets[index].enumerated().first(where: {
            $0.1.key == key
        }) {
            buckets[index].remove(at: i)
            count -= 1
            return element.value
        }

        // If we can't find the key-value pair just return nil
        return nil
    }
}

var ht = HashTable<String, String>(capacity: 5)

ht["lastName"] = "Thapa"
ht["firstName"] = "Steve"
ht["firstName"] = "Prayash"

print(ht)

if let firstName = ht["firstName"] {
    print(firstName)
}

ht["firstName"] = nil
if let firstName = ht["firstName"] {
    print(firstName)
} else {
    print("firstName key is not in the hash table")
}
