/**
 Write an algorithm to determine if a number is "happy".

 A happy number is a number defined by the following process: Starting with any
 positive integer, replace the number by the sum of the squares of its digits, and
 repeat the process until the number equals 1 (where it will stay), or it loops
 endlessly in a cycle which does not include 1. Those numbers for which this
 process ends in 1 are happy numbers.

 Input: 19
 Output: true
 Explanation:
 1^2 + 9^2 = 82
 8^2 + 2^2 = 68
 6^2 + 8^2 = 100
 1^2 + 0^2 + 0^2 = 1
 */

class Solution {
    /**
     Detect cycles with a Set, popping digits off one at a time. If the number is
     happy, then we'd never run into a cycle. We have to store all the numbers we see, and
     also sum all the digits.
     - Complexity:  O(log n) time and O(log n) space
     */
    func isHappy(_ n: Int) -> Bool {
        var seen = Set<Int>()
        var num = n

        while num != 1 && !seen.contains(num) {
            seen.insert(num)
            num = getNext(num)
        }

        return num == 1
    }

    /**
     Floyd's Cycle-Finding Algorithm:
     Instead of keeping track of just one value in the chain, we keep track of 2, called
     the slow runner and the fast runner. At each step of the algorithm, the slow runner
     goes forward by 1 number in the chain, and the fast runner goes forward by 2
     numbers (nested calls to the getNext(n) function).

     If n is a happy number, i.e. there is no cycle, then the fast runner will eventually
     get to 1 before the slow runner.

     If n is not a happy number, then eventually the fast runner and the slow runner will
     be on the same number.
     - Complexity: O(log n) runtime, but O(1) space
     */
    func isHappyFloydCycle(_ n: Int) -> Bool {
        var slow = n
        var fast = getNext(n)

        while fast != 1 && slow != fast {
            slow = getNext(slow)
            fast = getNext(getNext(fast))
        }

        return fast == 1
    }

    /**
     Calculate the sum of squaring the two digits. Why O(log n)?
     Because we're not iterating n amount of times, we're operating log(n) amount
     of times. Each iteration the value gets dividied by 10, which is logarithmic.
     https://stackoverflow.com/a/50262470/2272112
     */
    func getNext(_ n: Int) -> Int {
        var num = n
        var sum = 0

        while num > 0 {
            let d = num % 10
            num /= 10
            sum += d * d
        }

        return sum
    }
}


print(Solution().isHappyFloydCycle(19))
