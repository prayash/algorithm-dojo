// Represent the equation in a tree
// 5 + 25 * 6
//          '+'
//        /     \
//      '*'      5
//     /   \
//    25    6

// Node that represents a value or operator in the AST

class Node {
    var operation: String?
    var value: Float?
    var leftChild: Node?
    var rightChild: Node?

    init(operation: String?, value: Float?, leftChild: Node?, rightChild: Node?) {
        self.operation = operation
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

//     +
//   *   5
// 25  6

let sixNode = Node(operation: nil, value: 6, leftChild: nil, rightChild: nil)
let fiveNode = Node(operation: nil, value: 5, leftChild: nil, rightChild: nil)
let twentyFiveNode = Node(operation: nil, value: 25, leftChild: nil, rightChild: nil)

let mult25_6Node = Node(operation: "*", value: nil, leftChild: twentyFiveNode, rightChild: sixNode)
let rootPlusNode = Node(operation: "+", value: nil, leftChild: mult25_6Node, rightChild: fiveNode)

func evaluate(node: Node) -> Float {
    if (node.value != nil) {
        return node.value!
    }

    switch node.operation! {
    case "+":
        return evaluate(node: node.leftChild!) + evaluate(node: node.rightChild!)

    case "*":
        return evaluate(node: node.leftChild!) * evaluate(node: node.rightChild!)

    case "-":
        return evaluate(node: node.leftChild!) - evaluate(node: node.rightChild!)

    case "/":
        if (node.rightChild?.value == 0) { return 0 }
        return evaluate(node: node.leftChild!) / evaluate(node: node.rightChild!)

    default:
        return 0
    }

}

evaluate(node: rootPlusNode)
