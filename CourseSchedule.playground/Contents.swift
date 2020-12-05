/**
 There are a total of n courses you have to take, labeled from 0 to n-1.
 Some courses may have prerequisites, for example to take course 0 you have to
 first take course 1, which is expressed as a pair: [0,1]

 Given the total number of courses and a list of prerequisite pairs, is it
 possible for you to finish all courses?

 Input: 2, [[1,0]]
 Output: true
 Explanation: There are a total of 2 courses to take.
              To take course 1 you should have finished course 0. So it is possible.

 Input: 2, [[1,0],[0,1]]
 Output: false
 Explanation: There are a total of 2 courses to take.
              To take course 1 you should have finished course 0, and to take course 0 you should
              also have finished course 1. So it is impossible.
 */

class Solution {
    /**
     Topological sort on a directed acyclic graph. The function will return false if it's not a DAG.
     We need to answer the question: Is there a cycle in this directed graph?
     - Complexity: O(v + e) to enumerate all nodes and edges
     */
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var adj: [Int: [Int]] = [:]
        var inDegrees: [Int] = Array(repeatElement(0, count: numCourses))

        // Create an adjacency list representation of the dependency graph
        // Count all in degrees of each node
        for pr in prerequisites {
            let fromVertex = pr[1]
            let toVertex = pr[0]
            var list = adj[fromVertex, default: []]

            list.append(toVertex)
            adj[fromVertex] = list
            inDegrees[toVertex] += 1
        }

//        print(adj.description)

        // We'll use this to keep track of all the nodes that we have pulled from
        // our queue whose in-degree is 0
        var count = 0
        var queue = [Int]()

        // Push every single node with in-degree of 0 into our queue
        for i in 0..<inDegrees.count {
            if inDegrees[i] == 0 {
                queue.append(i)
            }
        }

        // Kick off the BFS
        while !queue.isEmpty {
            let current = queue.removeFirst()

            // If the node we pop out of the queue has in-degree of 0, increment count
            if inDegrees[current] == 0 {
                count += 1
            }

            // If the node has no neighbors, no need to decrement in-degrees
            guard let neighbors = adj[current] else {
                continue
            }

            for neighbor in neighbors {
                inDegrees[neighbor] -= 1

                // If after decrementing the neighbor's in-degree, it gets to 0
                // We'll add this to the queue. If this condition doesn't pass
                // we'll stop here because nothing can be added to the queue
                if inDegrees[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }

        return count == numCourses
    }
    
    func canFinishDFS(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var adj: [Int: [Int]] = [:]
        var visited = Set<Int>()
        var invalid = Set<Int>()
        
        for p in prerequisites {
            adj[p[0], default: []].append(p[1])
        }
        
        for i in 0..<numCourses {
            if invalid.contains(i) {
                continue
            }
            
            if !dfsHelper(adj, visited: &visited, invalid: &invalid, course: i) {
                return false
            }
        }
        
        return true
    }
    
    func dfsHelper(_ graph: [Int: [Int]], visited: inout Set<Int>, invalid: inout Set<Int>, course: Int) -> Bool {
        if invalid.contains(course) {
            return false
        }
        
        if visited.contains(course) {
            return false
        } else {
            visited.insert(course)
        }
        
        if let eligibleCourses = graph[course] {
            for c in eligibleCourses {
                if !dfsHelper(graph, visited: &visited, invalid: &invalid, course: c) {
                    invalid.insert(c)
                    return false
                }
            }
        }
        
        visited.remove(course)
        return true
    }
}

print(Solution().canFinish(2, [[1, 0], [0, 1]]))
print(Solution().canFinish(3, [[1, 0], [2, 0]]))
print(Solution().canFinish(4, [[1, 0], [2, 1], [2, 3], [3, 2]]))
print(Solution().canFinish(2, [[0, 1]]))
print(Solution().canFinishDFS(4, [[1, 0], [2, 1], [2, 3], [3, 2]]))
