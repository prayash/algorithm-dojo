import Foundation

/// Write a module to manage a pool of IDs can be reserved and released. This can be approached in
/// a multitude of ways, but a really fast one at the expense of some space is to use a binary-index
/// bit array.
///
/// Follow up:
/// - What happens if all IDs are used up? Throw an Exception or return nil.
///
/// Complexity:
/// - `O(log n)` time for allocation and release.
/// - `O(2 * n)` for space because every 2 digits add 1 extra unit of space for the parent node.
///
public final class IDAllocator: CustomStringConvertible {
    
    private let maximum: Int
    private var tree: [Bool]
    
    init(maximum: Int) {
        self.maximum = maximum
        self.tree = [Bool].init(repeating: false, count: 2 * maximum - 1)
    }
    
    /// Traverse the tree and find the leftmost child that is available.
    func allocate() -> Int {
        guard !tree[0] else {
            return -1
        }
        
        var index = 0
        while index < self.maximum - 1 {
            let left = 2 * index + 1
            let right = 2 * index + 2
            
            // If the left node is vacant, take it.
            if !tree[left] {
                index = left
            } else if !tree[right] {
                index = right
            } else {
                // We may have traversed all nodes without finding an available one.
                return -1
            }
            
            // We found a viable candidate to allocate. Let's update its parent to reflect that.
            tree[index] = true
            update(at: index)
        }
        
        return index - maximum + 1
    }
    
    /// If a bit has been flipped, its parent should be notified. A parent with
    /// both nodes flipped should be 1, indicating that no children are available.
    private func update(at index: Int) {
        print("Updating index \(index)")
        
        var index = index
        while index > 0 {
            let parent = (index - 1) / 2
            
            // Left child
            if index % 2 == 1 {
                tree[parent] = tree[index] && tree[index + 1]
            } else {
                tree[parent] = tree[index] && tree[index - 1]
            }
            
            index = parent
        }
    }
    
    func release(id: Int) {
        guard id <= maximum else {
            return
        }
        
        if tree[id + maximum - 1] {
            tree[id + maximum - 1] = false
            update(at: id + maximum - 1)
        }
    }
    
    public var description: String {
        return tree.reduce("") { (acc: String, currentBit: Bool) -> String in
            return acc + (currentBit ? "1 " : "0 ")
        }
    }
}

let allocator = IDAllocator(maximum: 5)
print(allocator)
for _ in 0..<6 {
    print("\(allocator.allocate()) -> \(allocator)")
}

print("Release id: 3")
allocator.release(id: 3)
print("\(3) -> \(allocator)")
