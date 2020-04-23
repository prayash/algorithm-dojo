/**
 Union-Find (or Disjoint-set) is a data structure that can keep track of a set of elements
 partitioned into a number of disjoint (non-overlapping) subsets. Sets are disjoint when
 they don't have any members in common.

 The most common application of this data structure is keeping track of the connected components
 of an undirected graph. It is also used for implementing an efficient version of
 Kruskal's algorithm to find the minimum spanning tree of a graph.


     parent [ 1, 1, 1, 0, 2, 0, 6, 6, 6 ]
           i  0  1  2  3  4  5  6  7  8

 then the tree structure looks like:

           1              6
         /   \           / \
       0       2        7   8
      / \     /
     3   5   4
 */
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


let edges = [[1,2], [1,3], [2,3]]
var dsu = UnionFind<Int>(size: edges.count + 1)

print(dsu.parent)
for e in edges {
    dsu.union(e[0], and: e[1])
}

print(dsu.parent)

/**
 A DSU data structure can be used to maintain knowledge of the connected components of a
 graph, and query for them quickly.

 In particular, we would like to support two operations:
    - `find`: Outputs a unique id so that two nodes have the same id if and only if they are in the same connect component
    - `union`: Draws an edge (x, y) in the graph connecting the components with id `find(x)` and `find(y)`
 */
class DisjointSetUnion {
    var parent: [Int]

    init(_ size: Int) {
        // 1-indexed so it's easy to match with node labels
        parent = [Int].init(repeating: 0, count: size + 1)

        for i in 0..<size + 1 {
            parent[i] = i
        }
    }

    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }

        return parent[x]
    }

    func union(_ x: Int, _ y: Int) -> Bool {
        let xr = find(x)
        let yr = find(y)

        print(parent)

        // The parent of x is already the parent of y
        // This is the redundant edge!
        if xr == yr {
            return false
        } else {
            // Update the connected components
            parent[yr] = xr
        }

        return true
    }
}
