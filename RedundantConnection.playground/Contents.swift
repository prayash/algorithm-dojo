/**
 In this problem, a tree is an undirected graph that is connected and has no cycles.

 The given input is a graph that started as a tree with N nodes (with distinct values 1, 2, ..., N),
 with one additional edge added. The added edge has two different vertices chosen from 1 to N, and
 was not an edge that already existed.

 The resulting graph is given as a 2D-array of edges. Each element of edges is a pair [u, v] with u
 LT v, that represents an undirected edge connecting nodes u and v.

 Return an edge that can be removed so that the resulting graph is a tree of N nodes. If there
 are multiple answers, return the answer that occurs last in the given 2D-array. The answer
 edge [u, v] should be in the same format, with u less than v.

     Example 1:
     Input: [[1,2], [1,3], [2,3]]
     Output: [2,3]
     Explanation: The given undirected graph will be like this:
       1
      / \
     2 - 3

    Example 2:
     Input: [[1,2], [2,3], [3,4], [1,4], [1,5]]
     Output: [1,4]
     Explanation: The given undirected graph will be like this:
     5 - 1 - 2
         |   |
         4 - 3
 */

class Solution {
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        var dsu = UnionFind<Int>(size: edges.count + 1)

        for e in edges {
            if !dsu.union(e[0], and: e[1]) {
                return e
            }
        }

        return []
    }
}

print(Solution().findRedundantConnection([[1,2], [1,3], [2,3]]))
print(Solution().findRedundantConnection([[1,2], [2,3], [3,4], [1,4], [1,5]]))

struct UnionFind<T: Hashable> {
    typealias DisjointSet = UnionFind
    var index = [T: Int]()
    var parent = [Int]()
    var size = [Int]()

    init(size: Int) {
        for i in 0..<size + 1 {
          addSetWith(i as! T)
        }
    }

    /**
     Save the index of the new element in the `index` dictionary. Allows for quick lookup.
     We then add that index to the `parent` array to build a new tree for this set. `parent[i]`
     is pointing to itself because the tree that represents the new set contains only one node.
     */
    mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }

    /**
     Look up the element's index in the `index` dictionary. We often want to determine
     whether we already have a set that contains a given element.
     - Complexity: O(1)
     */
    mutating func setOf(_ element: T) -> Int? {
        if let idxOfElement = index[element] {
            return setByIndex(idxOfElement)
        } else {
            return nil
        }
    }

    /**
     Find the set that an element belongs to, and return that set's root node.
     - Complexity: O(1)
     */
    mutating func setByIndex(_ i: Int) -> Int {
        // First, we check if the given index represents a root node
        if i != parent[i] {
            // Recursively call this method on the parent of the current node.
            // We then overwrite the parent of the current node with the index
            // of the root node, in effect reconnecting the node directly to the root
            // of the tree. This is an optimization to avoid O(n) complexity.
            parent[i] = setByIndex(parent[i])
            return parent[i]
        }

        return parent[i]
    }

    /**
     Helper to check whether two elements belong to the same set.
     - Complexity: O(n)
     */
    mutating func isSameSet(_ first: T, _ second: T) -> Bool {
        if let firstSet = setOf(first), let secondSet = setOf(second) {
            
            return firstSet == secondSet
        } else {
            return false
        }
    }

    /**
     Combines two sets into a larger set.
     - Complexity: O(1)
     */
    @discardableResult
    public mutating func union(_ firstElement: T, and secondElement: T) -> Bool {
        // Find the sets that each element belongs to, giving us the indices of the
        // root nodes in parent.
        guard let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) else {
            return false
        }

        // No point in performing union if they both belong to the same set.
        if firstSet != secondSet {
            // We perform weighting to keep trees as shallow as possible, so we'll attach
            // the smaller tree to the root of the larger tree.
            if size[firstSet] < size[secondSet] {
                parent[firstSet] = secondSet
                size[secondSet] += size[firstSet]
            } else {
                parent[secondSet] = firstSet
                size[firstSet] += size[secondSet]
            }

            return true
        }

        return false
    }
}
