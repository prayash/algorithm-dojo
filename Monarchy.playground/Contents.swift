protocol Monarchy {
    func birth(child: String, parent: String) -> Void
    func death(name: String) -> Void
    func getOrderOfSuccession() -> [String]
}

class RoyalFamily: Monarchy {

    static let QUEEN = "queen"
    var hierarchy: [String: [String]] = [:]
    var deaths = Set<String>()

    init(queen: String) {
        hierarchy[queen] = []
    }

    func birth(child: String, parent: String) {
        hierarchy[parent, default: []].append(child)
    }

    func death(name: String) {
        deaths.insert(name)
    }

    /**
     N-ary tree with pre-order DFS traversal.
     */
    func getOrderOfSuccession() -> [String] {
        var lineOfSuccession = [String]()

        func dfs(_ root: String) {
            guard !deaths.contains(root) else {
                return
            }

            lineOfSuccession.append(root)
            if let children = hierarchy[root] {
                for child in children {
                    dfs(child)
                }
            }
        }

        dfs(RoyalFamily.QUEEN)

        return lineOfSuccession
    }

}

var rf = RoyalFamily(queen: RoyalFamily.QUEEN)
rf.birth(child: "charles", parent: RoyalFamily.QUEEN)
rf.birth(child: "harry", parent: RoyalFamily.QUEEN)
rf.birth(child: "william", parent: RoyalFamily.QUEEN)
rf.birth(child: "albert", parent: "charles")
rf.birth(child: "harry2", parent: "harry")
rf.birth(child: "harry3", parent: "harry")

print(rf.getOrderOfSuccession())
