enum EdgeType {
    case directed, undirected
}

struct Edge<T: Hashable> {
    var source: Vertex<T>
    var destination: Vertex<T>
    let weight: Double?
}

struct Vertex<T: Hashable> {
    var data: T
}

extension Vertex: Hashable, CustomStringConvertible {
    var hashValue: Int {
        return "\(data)".hashValue
    }

    static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }

    var description: String {
        return "\(data)"
    }
}

extension Edge: Hashable {
    var hashValue: Int {
        return "\(source)\(destination)\(weight!)".hashValue
    }

    static func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}

protocol Graphable {
    associatedtype E: Hashable
    var description: CustomStringConvertible { get }

    func createVertex(data: E) -> Vertex<E>
    func add(_ type: EdgeType, from source: Vertex<E>, to destination: Vertex<E>, weight: Double?)
    func weight(from source: Vertex<E>, to desination: Vertex<E>) -> Double?
    func edges(from source: Vertex<E>) -> [Edge<E>]?
}

class AdjacencyList<T: Hashable> {
    var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    init() {}

    private func addDirectedEdge(from source: Vertex<E>, to destination: Vertex<E>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge)
    }

    private func addUndirectedEdge(vertices: (Vertex<E>, Vertex<E>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension AdjacencyList: Graphable {
    typealias E = T

    func createVertex(data: E) -> Vertex<E> {
        let vertex = Vertex(data: data)

        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }

        return vertex
    }

    func add(_ type: EdgeType, from source: Vertex<E>, to destination: Vertex<E>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }

    func weight(from source: Vertex<E>, to desination: Vertex<E>) -> Double? {
        guard let edges = adjacencyDict[source] else { return nil }

        for edge in edges {
            if edge.destination == desination {
                return edge.weight
            }
        }

        return nil
    }

    func edges(from source: Vertex<E>) -> [Edge<E>]? {
        return adjacencyDict[source]
    }

    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n")
        }
        return result
    }
}

let adjacencyList = AdjacencyList<String>()

let singapore = adjacencyList.createVertex(data: "Singapore")
let tokyo = adjacencyList.createVertex(data: "Tokyo")
let hongKong = adjacencyList.createVertex(data: "Hong Kong")
let detroit = adjacencyList.createVertex(data: "Detroit")
let sanFrancisco = adjacencyList.createVertex(data: "San Francisco")
let washingtonDC = adjacencyList.createVertex(data: "Washington DC")
let austinTexas = adjacencyList.createVertex(data: "Austin Texas")
let seattle = adjacencyList.createVertex(data: "Seattle")

adjacencyList.add(.undirected, from: singapore, to: hongKong, weight: 300)
adjacencyList.add(.undirected, from: singapore, to: tokyo, weight: 500)
adjacencyList.add(.undirected, from: hongKong, to: tokyo, weight: 250)
adjacencyList.add(.undirected, from: tokyo, to: detroit, weight: 450)
adjacencyList.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
adjacencyList.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
adjacencyList.add(.undirected, from: detroit, to: austinTexas, weight: 50)
adjacencyList.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
adjacencyList.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
adjacencyList.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
adjacencyList.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
adjacencyList.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(adjacencyList.description)
