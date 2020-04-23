/**
 You have one chocolate bar that consists of some chunks. Each chunk has its own sweetness
 given by the array sweetness.

 You want to share the chocolate with your K friends so you start cutting the chocolate bar
 into K+1 pieces using K cuts, each piece consists of some consecutive chunks.

 Being generous, you will eat the piece with the minimum total sweetness and give the other
 pieces to your friends.

 Find the maximum total sweetness of the piece you can get by cutting the chocolate bar optimally.

 Example 1:
 Input: sweetness = [1,2,3,4,5,6,7,8,9], K = 5
 Output: 6
 Explanation: You can divide the chocolate to [1,2,3], [4,5], [6], [7], [8], [9]
 */

class Solution {
    /**
     Binary search on the target answer, which is the TOTAL sweetness.
     - Complexity: O(n log n)
     */
    func maximizeSweetness(_ sweetness: [Int], _ K: Int) -> Int {
        var totalSweetness = 0
        var minimum = Int(Int.max)

        for s in sweetness {
            totalSweetness += s
            minimum = min(s, minimum)
        }

        if K == 0 {
            return totalSweetness
        }

        var l = minimum
        var r = totalSweetness

        while l <= r {
            let mid = l + (r - l) / 2

            // Can we successfully divide the array into K parts?
            if requiredChunks(mid, sweetness) > K {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }

        return l
    }

    func requiredChunks(_ target: Int, _ nums: [Int]) -> Int {
        var chunks = 0
        var totalSweetness = 0

        for n in nums {
            totalSweetness += n
            if totalSweetness > target {
                chunks += 1
                totalSweetness = 0
            }
        }

        return chunks
    }
}

print(Solution().maximizeSweetness([1,2,3,4,5,6,7,8,9], 5))
