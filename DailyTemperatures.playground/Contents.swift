/**
 Given a list of daily temperatures T, return a list such that, for each day in the input, tells
 you how many days you would have to wait until a warmer temperature. If there is no future day for
 which this is possible, put 0 instead.

 For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76, 73], your output
 should be [1, 1, 4, 2, 1, 1, 0, 0].

 Note: The length of temperatures will be in the range [1, 30000]. Each temperature will be an integer
 in the range [30, 100].
 */

class Solution {
    /**
     Nested loop.. O(n ^ 2) time and O(n) space.
     */
    func dailyTemperaturesNaive(_ T: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: T.count)

        for i in 0..<T.count {
            let currentTemp = T[i]

            for j in i + 1..<T.count {
                if T[j] > currentTemp {
                    result[i] = j - i
                    break
                }
            }
        }

        return result
    }

    /**
     O(n) time where n is the length of T. We make a single pass using the stack to keep
     track of increasing temp indices. O(W) space because the size of the stack is bounded as it
     represents increasing temps only.
     Stack boi method.
     */
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: T.count)
        var stack = [Int]()

        guard T.count > 2 else { return result }

        for i in 0..<T.count {
            // If our stack isn't empty, and the last temp we pushed is smaller than the current one
            // That means we've found a warmer day. Update that index with the difference between
            // now and then!
            while !stack.isEmpty && T[i] > T[stack.last!] {
                let t = stack.popLast()
                result[t!] = i - t!
            }

            stack.append(i)
        }

        return result
    }
}

var temps = [73, 74, 75, 71, 69, 72, 76, 73]
print(Solution().dailyTemperatures(temps))
