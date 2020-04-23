class Node {
    var visited = false
    var edge: [Edge] = []
}

class Edge {
    public let to: Node
    public let weight: Int

    init(to node: Node, weight: Int) {
        assert(weight >= 0, "Weight canont be a negative number.")
        self.to = node
        self.weight = weight
    }
}

class Path {
    /// The cost to reach the `to` path's node
    let cumulativeWeight: Int

    let node: Node
    let prevPath: Path?

    init(to node: Node, via connection: Edge? = nil, prevPath path: Path? = nil) {
        if let prevPath = path, let viaConnection = connection {
            cumulativeWeight = viaConnection.weight + prevPath.cumulativeWeight
        } else {
            cumulativeWeight = 0
        }

        self.node = node
        self.prevPath = path
    }

    var array: [Node] {
        var array: [Node] = [self.node]

        var iterativePath = self
        while let path = iterativePath.prevPath {
            array.append(path.node)

            iterativePath = path
        }

        return array
    }
}

func dijkstrasShortestPath(source: Node, destination: Node) -> Path? {
    /// Ideally, this would be a priority queue and not a basic queue.
    var paths: [Path] = [] {
        didSet {
            /// Naive, and expensive. Worth exploring the priority queue version.
            paths.sort { $0.cumulativeWeight < $1.cumulativeWeight }
        }
    }

    // We begin the path by starting from a nil path to the beginning node
    paths.append(Path(to: source))

    while !paths.isEmpty {
        let cheapestPath = paths.removeFirst()

        // Ensure we haven't already visited this node
        guard !cheapestPath.node.visited else {
            continue
        }

        // Are we sure we aren't already at the destination?
        if cheapestPath.node === destination {
            return cheapestPath
        }

        cheapestPath.node.visited = true

        for edge in cheapestPath.node.edge where !edge.to.visited {
            paths.append(Path(to: edge.to, via: edge, prevPath: cheapestPath))
        }
    }

    return nil
}

class GraphNode: Node {
    let name: String

    init(name: String) {
        self.name = name
        super.init()
    }
}

let nodeA = GraphNode(name: "A")
let nodeB = GraphNode(name: "B")
let nodeC = GraphNode(name: "C")
let nodeD = GraphNode(name: "D")
let nodeE = GraphNode(name: "E")

nodeA.edge.append(Edge(to: nodeB, weight: 1))
nodeB.edge.append(Edge(to: nodeC, weight: 3))
nodeC.edge.append(Edge(to: nodeD, weight: 1))
nodeB.edge.append(Edge(to: nodeE, weight: 1))
nodeE.edge.append(Edge(to: nodeC, weight: 1))

let sourceNode = nodeA
let destinationNode = nodeD
var path = dijkstrasShortestPath(source: sourceNode, destination: destinationNode)

if let succession: [String] = path?.array
    .reversed()
    .compactMap({ $0 as? GraphNode })
    .map({ $0.name }) {
    print("🏁 Quickest path: \(succession)")
} else {
    print("💥 No path between \(sourceNode.name) & \(destinationNode.name)")
}
