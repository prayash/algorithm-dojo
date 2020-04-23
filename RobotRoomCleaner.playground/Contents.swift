class Robot {
    func clean() {

    }

    func move() -> Bool {
        return true
    }

    func turnRight() {

    }

    func turnLeft() {}
}

class Solution {
    var directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

    /**
     Spiral backtracking.
     - Complexity: O(4 ^ (n - m)) where n is number of cells and m is number of obstacles. The algorithm
     checks all 4 directions for each cell.
     */
    func cleanRoom(_ robot: Robot) {
        var visited = Set<String>()
        var currDir = 0

        backtrack(robot, &visited, 0, 0, &currDir)
    }

    func backtrack(_ robot: Robot, _ visited: inout Set<String>, _ i: Int, _ j: Int, _ currDir: inout Int) {
        let coords = "\(i), \(j)"

        if visited.contains(coords) {
            return
        } else {
            robot.clean()
            visited.insert(coords)

            for _ in 0..<4 {
                if robot.move() {
                    let ii = i + directions[currDir][0]
                    let jj = j + directions[currDir][1]

                    backtrack(robot, &visited, ii, jj, &currDir)

                    // Unchoose
                    robot.turnLeft()
                    robot.turnLeft()
                    robot.move()
                    robot.turnLeft()
                    robot.turnLeft()
                }

                robot.turnRight()
                currDir = (currDir + 1) % 4
            }
        }
    }
}
