/**
 The Fibonacci numbers are the numbers in the following integer sequence.
 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 ...
 */
class Solution {
    /**
     Recursive brute force: O(2 ^ n) 🤮
     Time Complexity: T(n) = T(n - 1) + T(n - 2) which is exponential.
     We can observe that this implementation does a lot of repeated work (see the following recursion tree). So this is a bad implementation for nth Fibonacci number.
                                fib(5)
                          /                \
                    fib(4)                fib(3)
                  /        \              /       \
              fib(3)      fib(2)         fib(2)   fib(1)
             /    \       /    \        /      \
        fib(2)   fib(1) fib(1) fib(0) fib(1) fib(0)
       /     \
    fib(1)  fib(0)
     */
    func fib(_ n: Int) -> Int {
        guard n > 1 else { return n }

        return fib(n - 1) + fib(n - 2)
    }

    /**
     DP solution using memoization 😎
     Time Com­plex­ity: O(n), Space Com­plex­ity: O(n)
     */
    func fibDP(_ n: Int) -> [Int] {
        // Define a collection to cover the base case and build up
        var memo: [Int] = Array(repeating: 0, count: n + 1)

        memo[0] = 0
        memo[1] = 1

        for i in 2...n {
            memo[i] = memo[i - 1] + memo[i - 2]
        }

        return memo
    }

    /**
     DP solution using memoization + constant space. Store the last two calculated values only.
     Time Com­plex­ity: O(n), Space Com­plex­ity: O(1)
     */
    func fibDPConstantSpace(_ n: Int) -> Int {
        guard n != 0 && n != 1 else {
            return n
        }

        // We'll be building the fibonacci series from the bottom up
        // so we'll need to track the previous 2 numbers at each step
        var prevPrev = 0    // 0th Fibonacci
        var prev = 1        // 1st Fibonacci
        var current = 0     // Our holder for the summation

        for _ in 1..<n {
            // Sum the two previous values
            current = prev + prevPrev

            // Update stored values
            prevPrev = prev
            prev = current
        }

        return current
    }
}

// This will take FOREVER!
 print(Solution().fibDP(50))

// This will take a split second.
//print(Solution().fibDP(10))
//print(Solution().fibDPConstantSpace(10))
