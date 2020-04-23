/**
 You are given a perfect binary tree where all leaves are on the same level, and every
 parent has two children. The binary tree has the following definition:

     struct Node {
       int val;
       Node *left;
       Node *right;
       Node *next;
     }

 Populate each next pointer to point to its next right node. If there is no next right
 node, the next pointer should be set to NULL.

 Initially, all next pointers are set to NULL.

 Follow up:
 You may only use constant extra space.
 Recursive approach is fine, you may assume implicit stack space does not count as extra
 space for this problem.
 */

class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?

    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

class Solution {
    /**
     BFS (level-order traversal) and set each node's next to the one succeeding it in the queue.
     - Complexity: O(n) to process all nodes.
     */
    func connect(_ root: Node?) -> Node? {
        guard let root = root else { return nil }

        var bfsQueue: [Node] = [root]

        while !bfsQueue.isEmpty {
            let size = bfsQueue.count

            // Iterate over all the nodes on the current level
            for i in 0..<size {
                // Slow..... use a linked list for the bfsQueue instead!
                let node = bfsQueue.removeFirst()

                // This check is important. We don't want to
                // establish any wrong connections. The queue will
                // contain nodes from 2 levels at most at any
                // point in time. This check ensures we only
                // don't establish next pointers beyond the end
                // of a level
                if i < size - 1 {
                    node.next = bfsQueue.first
                }

                if let left = node.left {
                    bfsQueue.append(left)
                }

                if let right = node.right {
                    bfsQueue.append(right)
                }
            }
        }

        return root
    }
}
