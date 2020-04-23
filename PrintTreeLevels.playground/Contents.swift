class Node {
    var val: Int
    var left: Node?
    var right: Node?

    init(_ val: Int) {
        self.val = val
    }
}

/**
 Print a tree using BFS and DFS.

       3
      / \
     9  20
       /  \
      15   7
 */
func treeLevels(_ root: Node?, f: (Int) -> ()) {
    guard let root = root else {
        return
    }

    var bfsQueue: [Node] = [root]
    while !bfsQueue.isEmpty {
        let node = bfsQueue.removeFirst()

        f(node.val)

        if let left = node.left {
            bfsQueue.append(left)
        }

        if let right = node.right {
            bfsQueue.append(right)
        }
    }
}

//func treeLevelsDFS(_ root: Node?, f: (Int) -> ()) {
//    guard let root = root else {
//        return
//    }
//
//    var dfsStack: [Node] = [root]
//    while let node = dfsStack.popLast() {
//        f(node.val)
//
//        if let left = node.left {
//            dfsStack.append(left)
//        }
//
//        if let right = node.right {
//            dfsStack.append(right)
//        }
//    }
//}

func treeLevelsDFS(_ root: Node?, f: (Int) -> ()) -> () {
    guard let node = root else {
        return
    }

    var stack: [Node] = [node]
    while !stack.isEmpty {
        for _ in 0..<stack.count {
            let n = stack.removeFirst()
            print(n.val)

            if n.left != nil {
                stack.append(n.left!)
            }

            if n.right != nil {
                stack.append(n.right!)
            }
        }
    }
}

var root = Node(3)
root.left = Node(9)
root.right = Node(20)
root.right?.left = Node(15)
root.right?.right = Node(7)

print("BFS - - - - - - - - \n")
treeLevels(root) { (val) in
    print(val)
}
print("- - - - - - - - \n")

print("DFS - - - - - - - - \n")
treeLevelsDFS(root) { (val) in
    print(val)
}

print("- - - - - - - - \n")
