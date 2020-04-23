/**
 Queue based arrays allow for fast insertions at O(1) time because we append to the back, but
 removing items from the front of the queue is slow at O(n), because it requires the remaining
 elements to be shifted in memory.

 A more efficient way to implement a queue is to use a circular buffer. This is an array that
 conceptually wraps around to the beginning of the array, so we never really have to remove any items,
 but simply overwrite them. All ops become O(1), but we have one huge disadvantage: resizing is tricky.
 It's best to use this type of data structure when we have a fixed size queue. This buffer is NOT thread-safe.

     [ 123, 456, 789, 666, nil ]
        r
             -------------> w
 */
struct CircularBuffer<T> {
    private var array: [T?]
    private var readPtr = 0
    private var writePtr = 0

    init(size: Int) {
        array = [T?](repeating: nil, count: size)
    }

    mutating func write(_ element: T) -> Bool {
        guard !isFull else { return false }

        array[writePtr % array.count] = element
        writePtr += 1
        return true
    }

    mutating func read() -> T? {
        guard !isEmpty else { return nil }

        if let element = array[readPtr % array.count] {
            readPtr += 1
            return element
        }

        return nil
    }

    private var availableSpaceForReading: Int {
        return writePtr - readPtr
    }

    private var isEmpty: Bool {
        return availableSpaceForReading == 0
    }

    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }

    var isFull: Bool {
        return availableSpaceForWriting == 0
    }
}

var buffer = CircularBuffer<Int>(size: 5)

buffer.write(123)
buffer.write(456)
buffer.write(789)
buffer.write(666)

buffer.read()   // 123
buffer.read()   // 456
buffer.read()   // 789

buffer.write(333)
buffer.write(555)

buffer.read()   // 666
buffer.read()   // 333
buffer.read()   // 555
buffer.read()   // nil
