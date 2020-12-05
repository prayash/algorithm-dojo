import Foundation

/// Swift's built in Dictionary and Array types are value types—meaning that when they're modified,
/// their reference is fully replaced with a new copy of the structure. Because updating instance
/// variables on Swift objects is not atomic, they aren't thread-safe. So if we have the dictionary
/// being updated from two different threads in our app, they both may attempt to write at the same
/// block of memory. This can lead to memory corruption and other race conditions which are hard to debug.
///
/// The trick to making it thread safe is to use a private isolation key within our data structure that
/// limits reads during writes. This is more commonly called a reader-writer lock, and can be implemented
/// in various ways. Using Grand Central Dispatch, the recipe is simple. Concurrent, synchronous reads,
/// and serial, asynchronous writes.
///
/// Queues can be used as a synchronization mechanism in place of
/// more traditional locking constructs like `p_thread_lock` or `NSLock`. This way, we get parallelism (
/// (returns control to caller right away), safety (impossible to forget to unlock), and control (custom
/// queues, queue priority etc).
///
/// [Mike Ash's GCD Overview](https://www.mikeash.com/pyblog/friday-qa-2011-10-14-whats-new-in-gcd.html)
class ThreadSafeMap<T: Identifiable>: CustomStringConvertible {
    
    /// Internal data structure to back the map,
    private var _internal = Dictionary<String, T>()
    
    /// Our isolation queue.
    private let isolationQueue = DispatchQueue(label: "io.prayash.q", attributes: .concurrent)
    
    /// Synchronous, concurrent read.
    func read(at key: String) -> T? {
        return isolationQueue.sync {
            _internal[key] ?? nil
        }
    }

    /// Asynchronous, serial write.
    func write(_ item: T, at key: String) {
        isolationQueue.async(flags: .barrier) {
            self._internal[key] = item
        }
    }

    var description: String {
        return _internal.debugDescription
    }
}

extension Int: Identifiable {
    public var id: Int { return self }
}

var tsMap = ThreadSafeMap<Int>()
tsMap.write(111, at: "1")
tsMap.write(222, at: "2")

print(tsMap)
