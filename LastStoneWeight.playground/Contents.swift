/**
 We have a collection of rocks, each rock has a positive integer weight.

 Each turn, we choose the two heaviest rocks and smash them together.
 Suppose the stones have weights x and y with x LTE y.  The result of this smash is:

 If x == y, both stones are totally destroyed;
 If x != y, the stone of weight x is totally destroyed, and the stone of weight y has new weight y - x.
 At the end, there is at most 1 stone left.  Return the weight of this stone (or 0 if there are no stones left.)
 */

class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        var maxHeap = Heap<Int> { (lhs, rhs) -> Bool in
            return lhs > rhs
        }

        // Insert all stones into the max heap
        for s in stones {
            maxHeap.insert(s)
        }

        while !maxHeap.isEmpty {
            let x = maxHeap.remove()
            let y = maxHeap.remove()

            if let x = x, let y = y {
                // Insert difference in weight if not same.
                if x != y {
                    maxHeap.insert(x - y)
                }
            } else if let x = x, maxHeap.isEmpty {
                // If last element, just return
                return x
            }
        }

        return 0
    }
}

print(Solution().lastStoneWeight([2, 7, 4, 1, 8, 1]))
print(Solution().lastStoneWeight([2, 2]))

