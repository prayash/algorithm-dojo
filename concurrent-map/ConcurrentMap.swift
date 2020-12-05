import Foundation
import QuartzCore

public final class ThreadSafe<A> {
    var _value: A
    let queue = DispatchQueue(label: "io.prayash.concurrentMap")
    
    init(_ value: A) {
        self._value = value
    }
    
    var value: A {
        return queue.sync { _value }
    }
    
    func atomically(_ transform: (inout A) -> Void) {
        queue.sync {
            transform(&self._value)
        }
    }
}

extension Array {
    func concurrentMap<B>(nthreads:Int?=nil, _ transform: (Element) -> B) -> [B] {
        let result = ThreadSafe(Array<B?>(repeating: nil, count: count))
        let numThreads = nthreads ?? count
        let cs = (count-1) / numThreads + 1

        DispatchQueue.concurrentPerform(iterations: numThreads) { i in
            let min = i * cs
            let max = min + cs>count ? count : min+cs
            for idx in (min..<max) {
                let element = self[idx]
                let transformed = transform(element)
                
                result.atomically {
                    $0[idx] = transformed
                }
            }
        }
        return result.value.map { $0! }
    }
}


@discardableResult
func time<Result>(name: StaticString = #function, line: Int = #line, _ f: () -> Result) -> Result {
    let startTime = DispatchTime.now()
    let result = f()
    let endTime = DispatchTime.now()
    let diff = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000 as Double
    print("\(name) (line \(line)): \(diff) sec")
    return result
}

func time<R>(_ f: ()->R) -> (time: Double, result: R) {
    let startTime = CACurrentMediaTime()
    let r = f()
    let t = CACurrentMediaTime() - startTime
    return (t, r)
}

extension RandomAccessCollection {
    /// Returns `self.map(transform)`, computed in parallel.
    ///
    /// - Requires: `transform` is safe to call from multiple threads.
    func concurrentMap2<B>(minBatchSize: Int = 4096, _ transform: (Element) -> B) -> [B] {
        precondition(minBatchSize >= 1)
        let n = self.count
        let batchCount = (n + minBatchSize - 1) / minBatchSize
        if batchCount < 2 { return self.map(transform) }
        
        return Array(unsafeUninitializedCapacity: n) {
            uninitializedMemory, resultCount in
            resultCount = n
            let baseAddress = uninitializedMemory.baseAddress!
            
            DispatchQueue.concurrentPerform(iterations: batchCount) { b in
                let startOffset = b * n / batchCount
                let endOffset = (b + 1) * n / batchCount
                var sourceIndex = index(self.startIndex, offsetBy: startOffset)
                for p in baseAddress+startOffset..<baseAddress+endOffset {
                    p.initialize(to: transform(self[sourceIndex]))
                    formIndex(after: &sourceIndex)
                }
            }
        }
    }
}

// This oughta be an optimization, but doesn't seem to be!
extension Array {
    /// Returns `self.map(transform)`, computed in parallel.
    ///
    /// - Requires: `transform` is safe to call from multiple threads.
    func concurrentMap3<B>(_ transform: (Element) -> B) -> [B] {
        withUnsafeBufferPointer { $0.concurrentMap2(transform) }
    }
}

// Implementation with no unsafe constructs.
extension RandomAccessCollection {
    /// Returns `self.map(transform)`, computed in parallel.
    ///
    /// - Requires: `transform` is safe to call from multiple threads.
    func concurrentMap4<B>(_ transform: (Element) -> B) -> [B] {
        let batchSize = 4096 // Tune this
        let n = self.count
        let batchCount = (n + batchSize - 1) / batchSize
        if batchCount < 2 { return self.map(transform) }

        let batches = ThreadSafe(ContiguousArray<[B]?>(repeating: nil, count: batchCount))

        func batchStart(_ b: Int) -> Index {
            index(startIndex, offsetBy: b * n / batchCount)
        }
        
        DispatchQueue.concurrentPerform(iterations: batchCount) { b in
            let batch = self[batchStart(b)..<batchStart(b + 1)].map(transform)
            batches.atomically { $0[b] = batch }
        }
        
        return batches.value.flatMap { $0! }
    }
}

func test(count: Int, _ transform: (Int)->Int) {
    let hugeCollection = 0...655360
    let hugeArray = Array(hugeCollection)

    func time<R>(_ f: ()->R) -> (time: Double, result: R) {
        let startTime = CACurrentMediaTime()
        let r = f()
        let t = CACurrentMediaTime() - startTime
        return (t, r)
    }

    let (t0, r0) = time { hugeArray.map(transform) }
    print("sequential map time:", t0, "(the one to beat)")

    let (t1, r1) = time { hugeArray.concurrentMap(transform) }
    print("concurrentMap1 time:", t1)

    let (t2, r2) = time { hugeArray.concurrentMap2(transform) }
    print("concurrentMap2 time:", t2)

    let (t3, r3) = time { hugeArray.concurrentMap3(transform) }
    print("concurrentMap3 time:", t3)

    let (t4, r4) = time { hugeArray.concurrentMap4(transform) }
    print("concurrentMap4 time:", t4)

    if r1 != r0 { fatalError("bad implementation 1") }
    if r2 != r0 { fatalError("bad implementation 2") }
    if r3 != r0 { fatalError("bad implementation 3") }
    if r4 != r0 { fatalError("bad implementation 4") }
}

let N = 65536

print("* Testing a fast operation, to show overhead")
test(count: N * 10) { $0 &+ 1 }
print()

print("* Testing slow operations")
let bigArray = Array(0...N)
for shift in 0..<5 {
    let M = (N >> 4) << shift
    let workload = bigArray.prefix(M)
    print("- worklaod size: ", workload.count)
    test(count: N) { workload.reduce($0, &+) }
}

// swiftc -O ConcurrentMap.swift -o cmap && ./cmap
