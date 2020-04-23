import Foundation

struct User: Hashable {
    let id: UUID
}

struct Event {
    var id: UUID
    var creator: User
    var date: Date
}

struct Calendar {
    var events: [Event]
}

extension Calendar {
    // O(1)
    // We're always pulling out the first record, so it'll be constant time
    func isFirstEvent(scheduledAfter date: Date) -> Bool {
        guard let firstEvent = events.first else {
            return false
        }

        return firstEvent.date > date
    }

    // O(n)
    // Worst-case, we'll have to iterate through the entire collection
    // to find the events we're looking for that match our criteria
    func events(scheduledAfter date: Date) -> [Event] {
        return events.filter { event in
            event.date > date
        }
    }

    // O(n)
    // Worst-case, we'll have to search through the entire array
    // to find the match
    func firstEvent(scheduledAfter date: Date) -> Event? {
        return events.first(where: { event in
            event.date > date
        })
    }

    // O(n * m) where n is the events and m is the users
    func events(createdByAnyOf users: [User]) -> [Event] {
        return events.filter { event in
            users.contains(event.creator)
        }
    }

    // O(n)
    // We can pass in the users collection as a set so that lookups take
    // O(1) time instead of O(n) time above
    func optimizedEvents(createdByAnyOf users: Set<User>) -> [Event] {
        return events.filter { event in
            users.contains(event.creator)
        }
    }

    // O(n ^ 2)
    func conflictingEvents() -> [Event] {
        return events.filter { event in
            events.contains(where: { otherEvent in
                guard event.id != otherEvent.id else {
                    return false
                }

                return event.date == otherEvent.date
            })
        }
    }

    // O(2n)
    // Rather than iterating through the entire events array as part of each
    // iteration, we can make a single pass to record the count of events for each date
    // then use that set when filtering
    func optimizedConflictingEvents() -> [Event] {
        var eventCountsForDates = [Date : Int]()

        for event in events {
            eventCountsForDates[event.date, default: 0] += 1
        }

        return events.filter { event in
            eventCountsForDates[event.date, default: 0] > 1
        }
    }

}

let user = User(id: UUID.init())
let e1 = Event(id: UUID.init(), creator: user, date: Date.init())
let e2 = Event(id: UUID.init(), creator: user, date: Date.init())

let calendar = Calendar(events: [e1, e2])
print(calendar.isFirstEvent(scheduledAfter: Date.init()))
print(calendar.events(scheduledAfter: Date.init()))
