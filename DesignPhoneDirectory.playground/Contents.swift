/**
 Design a Phone Directory which supports the following operations:

 get: Provide a number which is not assigned to anyone.
 check: Check if a number is available or not.
 release: Recycle or release a number.

     // Init a phone directory containing a total of 3 numbers: 0, 1, and 2.
     PhoneDirectory directory = new PhoneDirectory(3);

     // It can return any available phone number. Here we assume it returns 0.
     directory.get();

     // Assume it returns 1.
     directory.get();

     // The number 2 is available, so return true.
     directory.check(2);

     // It returns 2, the only number that is left.
     directory.get();

     // The number 2 is no longer available, so return false.
     directory.check(2);

     // Release number 2 back to the pool.
     directory.release(2);

     // Number 2 is available again, return true.
     directory.check(2);
 */

class PhoneDirectory {

    let max: Int
    var used = Set<Int>()
    var released = [Int]()

    /** Initialize your data structure here
        @param maxNumbers - The maximum numbers that can be stored in the phone directory. */
    init(_ maxNumbers: Int) {
        max = maxNumbers
    }

    /** Provide a number which is not assigned to anyone.
        @return - Return an available number. Return -1 if none is available. */
    func get() -> Int {
        guard used.count < max else { return -1 }

        let id = released.isEmpty ? used.count : released.removeLast()
        used.insert(id)
        return id
    }

    /** Check if a number is available or not. */
    func check(_ number: Int) -> Bool {
        print(used)
        return !used.contains(number)
    }

    /** Recycle or release a number. */
    func release(_ number: Int) {
        if let n = used.remove(number) {
            released.append(n)
        }
    }
}

let pd = PhoneDirectory(3)
pd.get()
pd.get()
pd.check(2)
