/**
 Design a HashMap without using any built-in hash table libraries.

 To be specific, your design should include these functions:
 put(key, value) : Insert a (key, value) pair into the HashMap. If the value already exists in the HashMap, update the value.
 get(key): Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key.
 remove(key) : Remove the mapping for the value key if this map contains the mapping for the key.

 Example:

     MyHashMap hashMap = new MyHashMap();
     hashMap.put(1, 1);
     hashMap.put(2, 2);
     hashMap.get(1);            // returns 1
     hashMap.get(3);            // returns -1 (not found)
     hashMap.put(2, 1);          // update the existing value
     hashMap.get(2);            // returns 1
     hashMap.remove(2);          // remove the mapping for 2
     hashMap.get(2);            // returns -1 (not found)
 */

class MyHashMap {

    private typealias Element = (key: Int, value: Int)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]

    private(set) public var count = 0
    var isEmpty: Bool {
        return count == 0
    }

    init(capacity: Int = 8) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }

    func index(for key: Int) -> Int {
        return abs(key.hashValue) % buckets.count
    }

    func get(_ key: Int) -> Int {
        let index = self.index(for: key)

        return buckets[index].first { $0.key == key }?.value ?? -1
    }

    @discardableResult
    func put(_ key: Int, _ value: Int) -> Int? {
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
    func remove(_ key: Int) -> Int? {
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

/**
 * Your MyHashMap object will be instantiated and called as such:
 * let obj = MyHashMap()
 * obj.put(key, value)
 * let ret_2: Int = obj.get(key)
 * obj.remove(key)
 */
