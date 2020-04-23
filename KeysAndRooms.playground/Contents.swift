/**
 There are N rooms and you start in room 0.  Each room has a distinct number in 0, 1, 2, ..., N-1,
 and each room may have some keys to access the next room.

 Formally, each room i has a list of keys rooms[i], and each key rooms[i][j] is an integer
 in [0, 1, ..., N-1] where N = rooms.length.  A key rooms[i][j] = v opens the room with number v.

 Initially, all the rooms start locked (except for room 0).
 You can walk back and forth between rooms freely.
 Return true if and only if you can enter every room.

 Example 1:
 Input: [[1],[2],[3],[]]
 Output: true
 Explanation:
 We start in room 0, and pick up key 1.
 We then go to room 1, and pick up key 2.
 We then go to room 2, and pick up key 3.
 We then go to room 3.  Since we were able to go to every room, we return true.

 Example 2:
 Input: [[1,3],[3,0,1],[2],[0]]
 Output: false
 Explanation: We can't enter the room with number 2.
 */

class Solution {
    /**
     Use DFS to traverse the graph, adding each visited index to a set.
     If the final set has the same count as the the number of rooms, then we've visited em all.
     - Complexity: O(n + e) where n is the number of rooms and e is the total number of keys.
     O(2n) to store DFS stack and visited Set.
     */
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        var visited = Set<Int>()
        var dfsStack: [Int] = []

        dfsStack.append(0)
        visited.insert(0)

        while !dfsStack.isEmpty {
            let keysInRoom = rooms[dfsStack.popLast()!]

            for key in keysInRoom {
                if !visited.contains(key) {
                    visited.insert(key)
                    dfsStack.append(key)
                }
            }
        }

        return visited.count == rooms.count
    }
}

print(Solution().canVisitAllRooms([[1],[2],[3],[]]))
print(Solution().canVisitAllRooms([[1,3],[3,0,1],[2],[0]]))
