class SomeObject {}
struct Notification {
    var name: String
    weak var object: AnyObject?
    var callback: (String) -> Void
}

/**
 A NotificationCenter object provides a mechanism for broadcasting information within
 a program. A NotificationCenter object is essentially a notification dispatch table.

 Objects register with a notification center to receive notifications (Notification objects)
 using the add(forName:object:using) method. Each invocation of this method specifies a
 notification name. Objects may register as observers of different notification name by
 calling this method several times.

 Objects can post notifications using the post(name:) method. All objects registered to the
 notification name will have their corresponding closure executed.

 Objects can unregister itself from one or all notifications by using the remove(forName:object:)
 method.
 */
class NotificationCenter {

    /// The default NotificationCenter singleton.
    static var defaultCenter = NotificationCenter()

    /// Internal hash table to store `NotificationObject` instances.
    var dispatchTable: [String: [Notification]] = [:]

    /**
     Add the given observer object to the notification name. When the given notification
     name is posted, the given `using` closure should be executed.

     - Parameters:
        - forName: The notification name the object is observing.
        - object: The observer object that is requesting to listen to the notification.
        - using: Closure to be executed the the notification is posted.
     */
    func add(forName name: String, object: AnyObject, using: @escaping (String) -> Void) -> Void {
        let notification = Notification(name: name, object: object, callback: using)

        if dispatchTable[name] != nil {
            dispatchTable[name]!.append(notification)
        } else {
            dispatchTable[name] = [notification]
        }
    }

    /**
     Post a notification with the given name.

     - Parameters:
        - name: The notification to post.
     */
    func post(name: String) -> Void {
        guard let notifs = dispatchTable[name] else { return }

        notifs.forEach { $0.callback(name) }
    }

    /**
     Remove the observer object from the given notification name.

     - Parameters:
        - name: The notification name the object is observing
        - object: The observer object that is requesting to no longer listen to the notification
     */
    func remove(name: String, object: AnyObject) -> Void {
        if dispatchTable[name] != nil {
            dispatchTable[name] = dispatchTable[name]!.filter({ (notification) -> Bool in
                return notification.object !== object
            })
        }
    }
}

let center = NotificationCenter.defaultCenter
let objectA = SomeObject()
let objectB = SomeObject()
let objectC = SomeObject()

center.add(forName: "notificationEvent1", object: objectA) { _ in
    print("Object A Event 1 happened")
}

center.add(forName: "notificationEvent2", object: objectA) { _ in
    print("Object A Event 2 happened")
}

center.add(forName: "notificationEvent2", object: objectB) { _ in
    print("Object B Event 2 happened")
}

center.add(forName: "notificationEvent3", object: objectB) { _ in
    print("Object B Event 3 happened")
}

center.add(forName: "notificationEvent3", object: objectC) { _ in
    print("Object C Event 3 happened")
}

center.add(forName: "notificationEvent1", object: objectC) { _ in
    print("Object C Event 1 happened")
}

print("Before remove Object C Event 1")
center.post(name: "notificationEvent1")

center.remove(name: "notificationEvent1", object: objectC)
print("After removing Object C Event 1")
center.post(name: "notificationEvent1")

/**
 Desired output:
 Before move Object C Event 1
 Object A Event 1 happened
 Object C Event 1 happened
 After remove Object C Event 1
 Object A Event 1 happened
 */
