/**
 Given a list of airline tickets represented by pairs of departure and arrival airports
 [from, to], reconstruct the itinerary in order. All of the tickets belong to a man
 who departs from JFK. Thus, the itinerary must begin with JFK.

 Note:
 If there are multiple valid itineraries, you should return the itinerary that has the
 smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"]
 has a smaller lexical order than ["JFK", "LGB"].
 All airports are represented by three capital letters (IATA code).
 You may assume all tickets form at least one valid itinerary.
 */
/**
 Given a list of airline tickets represented by pairs of departure and arrival airports
 [from, to], reconstruct the itinerary in order. All of the tickets belong to a man
 who departs from JFK. Thus, the itinerary must begin with JFK.

 Note:
 If there are multiple valid itineraries, you should return the itinerary that has the
 smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"]
 has a smaller lexical order than ["JFK", "LGB"].
 All airports are represented by three capital letters (IATA code).
 You may assume all tickets form at least one valid itinerary.
 */


class Solution {
/**
 O(V + E) time and O(n) space.
 For a directed graph, the sum of the sizes of the adjacency lists of all
 the nodes is E (total number of edges).
 */
func findItinerary(_ tickets: [[String]]) -> [String] {
    guard tickets.count > 0 else { return [] }

    var tMap = [String : [String]]()

    // Build an adjacency list
    for ticket in tickets {
        if var dest = tMap[ticket[0]] {
            dest.append(ticket[1])

            // Sort destinations in lexical order
            tMap[ticket[0]] = dest.sorted()
        } else {
            tMap[ticket[0]] = [ticket[1]]
        }
    }

    var itinerary = [String]()
    var toVisit = [String]()

    // We have to start from JFK as the problem specifies
    toVisit.append("JFK")

    while !toVisit.isEmpty, let lastAirport = toVisit.last {
        // If there are no airports to visit from the currently selected one
        // Add it to the itinerary
        if tMap[lastAirport] == nil || tMap[lastAirport]?.count == 0 {
            itinerary.append(lastAirport)
            toVisit.removeLast()
        } else {
            // Visit an airport by taking the first value from the adjacency list
            // And adding it to the stack
            let first = tMap[lastAirport]!.first!

            toVisit.append(first)
            tMap[lastAirport]!.removeFirst()
        }
    }

    // Reverse the itinerary since we add the deepest airport first
    return itinerary.reversed()
}
}

var tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
print(Solution().findItinerary(tickets))

tickets = [["JFK", "SFO"], ["JFK", "ATL"], ["SFO", "ATL"], ["ATL", "JFK"], ["ATL", "SFO"]]
print(Solution().findItinerary(tickets))
