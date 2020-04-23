class Node<T: Equatable> {
    var value: T
    var children: [Node] = []
    weak var parent: Node?

    init(value: T) {
        self.value = value
    }

    func add(child: Node) {
        children.append(child)
        child.parent = self
    }

    func search(value: T) -> Node? {

        if value == self.value {
            return self
        }

        for c in children {
            if let found = c.search(value: value) {
                return found
            }
        }

        return nil
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var text = "\(value)"

        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }

        return text
    }
}


let beverages = Node(value: "Beverages")
let hot = Node(value: "Hot")
let cold = Node(value: "Cold")

beverages.add(child: hot)
beverages.add(child: cold)

print(beverages)

beverages.search(value: "Cold")

let five = Node(value: 5)
five.add(child: Node(value: 2))

print(five)
