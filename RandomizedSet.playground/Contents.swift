/**
 Design a data structure that supports all following operations in average O(1) time.

 insert(val): Inserts an item val to the set if not already present.
 remove(val): Removes an item val from the set if present.
 getRandom: Returns a random element from current set of elements.
    Each element must have the same probability of being returned.

 // Init an empty set.
 RandomizedSet randomSet = new RandomizedSet();

 // Inserts 1 to the set. Returns true as 1 was inserted successfully.
 randomSet.insert(1);

 // Returns false as 2 does not exist in the set.
 randomSet.remove(2);

 // Inserts 2 to the set, returns true. Set now contains [1,2].
 randomSet.insert(2);

 // getRandom should return either 1 or 2 randomly.
 randomSet.getRandom();

 // Removes 1 from the set, returns true. Set now contains [2].
 randomSet.remove(1);

 // 2 was already in the set, so return false.
 randomSet.insert(2);

 // Since 2 is the only number in the set, getRandom always return 2.
 randomSet.getRandom();
 */

class RandomizedSet {

    var list: [Int] = [Int]()
    var hashMap: [Int : Int] = [:]

    // Inserts a value to the set.
    // Returns true if the set did not already contain the specified element.
    // Add value -> its index into dictionary, average O(1) time.
    // Append value to array list, average O(1) time as well.
    func insert(_ val: Int) -> Bool {
        if hashMap[val] != nil {
            return false
        }

        hashMap[val] = list.count
        list.append(val)

        return true
    }

    // Removes a value from the set. Returns true if the set contained the specified element.
    func remove(_ val: Int) -> Bool {
        // Retrieve the index of the element to delete from the hashmap
        guard let index = hashMap[val] else {
            return false
        }

        // Move the last element to the place of the element to delete
        let lastElement = list[list.count - 1]
        list[index] = lastElement
        hashMap[lastElement] = index

        // Delete last element
        list.popLast()
        hashMap[val] = nil

        return true
    }

    // Get a random element from the set.
    func getRandom() -> Int {
        return list[Int.random(in: 0..<list.count)]
    }
}


let obj = RandomizedSet()
let ret_1: Bool = obj.insert(1)
let ret_2: Bool = obj.insert(2)
let ret_3: Bool = obj.insert(3)
let ret_4: Bool = obj.remove(3)
let retRandom: Int = obj.getRandom()
