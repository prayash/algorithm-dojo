/**
 Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window. Example:

     let m = MovingAverage(3);
     m.next(1) = 1
     m.next(10) = (1 + 10) / 2
     m.next(3) = (1 + 10 + 3) / 3
     m.next(5) = (10 + 3 + 5) / 3
 */

class MovingAverage {
    var queue: [Int]
    var head = 0
    var sum = 0
    var count = 0

    init(_ size: Int) {
        queue = Array(repeating: 0, count: size)
    }

    /**
     O(1) time, because we never loop through our queue.
     O(n) space for the size of the circular queue.
     */
    func next(_ val: Int) -> Double {
        count += 1

        // Calculate tail pointer
        let tail = (head + 1) % queue.count

        // Add to the sum, and subtract the overwritten value
        sum += val - queue[tail]

        // We move the head to the previous tail
        head = tail

        // Overwrite the value in the corresponding slot
        queue[head] = val

        return Double(sum) / Double(min(count, queue.count))
    }
}

/**
 * Your MovingAverage object will be instantiated and called as such:
 * let obj = MovingAverage(size)
 * let ret_1: Double = obj.next(val)
 */

let m = MovingAverage(3);
m.next(1)
m.next(10)
m.next(3)
m.next(5)
