/**
 One way to serialize a binary tree is to use pre-order traversal. When we encounter
 a non-null node, we record the node's value. If it is a null node, we record using
 a sentinel value such as #.

          _9_
         /   \
        3     2
       / \   / \
      4   1  #  6
     / \ / \   / \
     # # # #   # #

 For example, the above binary tree can be serialized to the
 string "9,3,4,#,#,1,#,#,2,#,6,#,#", where # represents a null node.

 Given a string of comma separated values, verify whether it is a correct preorder
 traversal serialization of a binary tree. Find an algorithm without reconstructing the tree.

 Each comma separated value in the string must be either an integer or a
 character '#' representing null pointer.

 You may assume that the input format is always valid, for example it could never
 contain two consecutive commas such as "1,,3".

 Input: "9,3,4,#,#,1,#,#,2,#,6,#,#"
 Output: true
 */

class Solution {
    /**
     Let's scan through the string, and update an integer slots representing the number of
     slots left in the tree. Both a number of a null node take one slot. If at any point,
     the number of slots is negative, then the tree is invalid.
     - Complexity: O(n) time and O(1) space.
     */
    func isValidSerialization(_ preorder: String) -> Bool {
        var slots = 1

        for i in 0..<preorder.count {
            // Each node decrements the number of slots
            if preorder[i] == "," {
                slots -= 1

                if slots < 0 {
                    return false
                }

                // A non-empty node always creates two slots.
                if preorder[i - 1] != "#" {
                    slots += 2
                }
            }
        }

        slots = preorder[preorder.count - 1] == "#" ? slots - 1 : slots + 1

        return slots == 0
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

print(Solution().isValidSerialization("9,3,4,#,#,1,#,#,2,#,6,#,#"))
print(Solution().isValidSerialization("9,#,#,1"))
