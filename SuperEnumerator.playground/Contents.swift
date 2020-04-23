import Foundation
import UIKit

/**
 Design an enumerator (e.g. named SuperEnumerator) that  has two API's:
 - `- (id) nextObject`
 - `- (NSArray *) allObjects`

 When given an input array that has content that can be either
 NSNumbers or NSArray, will expand all arrays embedded inside it. That is, given an input of
 something like @[@1, @[@2, @[@3, @4]], @[ ], @5], each call to nextObject will display items
 in the expected order.
 */
class SuperEnumerator: NSEnumerator {
    private var subEnumerators: [NSEnumerator]

    init(objects: NSArray) {
        subEnumerators = [objects.objectEnumerator()]
    }

    /**
     Using recursion, keep a stack of sub enumerators mapped to how many levels deep the array
     is and utilize that to pop off the integers.
     */
    override func nextObject() -> Any? {
        guard let currentEnumerator = subEnumerators.last else {
            return nil
        }

        guard let currentObject = currentEnumerator.nextObject() else {
            subEnumerators.removeLast()
            return nextObject()
        }

        if let arr = currentObject as? NSArray {
            subEnumerators.append(arr.objectEnumerator())
            return nextObject()
        }

        return currentObject as? Int
    }

    override var allObjects: [Any] {
        var temp: [Any] = []
        while let obj = nextObject() {
            temp.append(obj)
        }

        return temp
    }
}

let e = SuperEnumerator(objects: NSArray(array: [4, 2, 0, 6, 9]))
e.nextObject()
e.nextObject()
e.nextObject()
e.nextObject()
e.nextObject()
e.nextObject()

let x = SuperEnumerator(objects: NSArray(array: [1, NSArray(array: [2, 3])]))
x.nextObject()
x.nextObject()
x.nextObject()
x.nextObject()
