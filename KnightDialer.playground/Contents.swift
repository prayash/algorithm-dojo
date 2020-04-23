class Soluton {
    let map: [Int : [Int]] = [
        1: [6, 8],
        2: [7, 9],
        3: [8, 4],
        4: [3, 9, 0],
        5: [],
        6: [1, 7, 0],
        7: [2, 6],
        8: [1, 3],
        9: [4, 2],
        0: [4, 6]
    ]

    func distinctNumbersNaive(_ N: Int, _ S: Int) -> Int {
        var set = Set<Int>()

        func helper(_ n: Int, _ node: Int, _ set: inout Set<Int>) {
            if n < 0 {
                return
            }

            set.insert(node)

            if let neighbors = map[node] {
                for neighbor in neighbors {
                    helper(n - 1, neighbor, &set)
                }
            }
        }

        helper(N, S, &set)

        return set.count
    }

    func distinctNumbersRecursive(_ N: Int, _ S: Int) -> Int {
        if N == 0 {
            return 1
        }

        var seq = 0
        if let neighbors = map[S] {
            for n in neighbors {
                seq += distinctNumbersNaive(N - 1, n)
            }
        }

        return seq
    }

    func knightDialer(_ N: Int) -> Int {

    }
}

print(Soluton().distinctNumbersDP(2, 6))
