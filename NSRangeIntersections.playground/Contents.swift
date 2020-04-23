import Foundation

class IntersectionRange {
    let range1: NSRange
    let range2: NSRange

    init(_ first: NSRange, _ second: NSRange) {
        range1 = first
        range2 = second
    }

    func intersection() -> NSRange? {
        let min1 = range1.location
        let max1 = range1.location + range1.length

        let min2 = range2.location
        let max2 = range2.location + range2.length

        if max2 < min1 || max1 < min2 {
            return nil
        } else {
            let minRange = max(min1, min2)
            let maxRange = min(max1, max2)

            return NSRange(location: minRange, length: maxRange - minRange)
        }
    }

    func doesIntersect() -> Bool {
        let startA = range1.location
        let endA = range1.location + range1.length

        let startB = range2.location
        let endB = range2.location + range2.length

        return max(startA, startB) < min(endA, endB)
    }
}

//let iRange = IntersectionRange(NSRange(location: 5, length: 17), NSRange(location: 10, length: 3))
//let intersection = iRange.intersection()
//
//print(IntersectionRange(NSRange(location: 3, length: 13), NSRange(location: 7, length: 12)).intersection()!)

let a = NSRange(location: 1, length: 5)
let b = NSRange(location: 3, length: 10)
print(IntersectionRange(a, b).doesIntersect())
print(IntersectionRange(b, a).doesIntersect())

let c = NSRange(location: 1, length: 2)
let d = NSRange(location: 3, length: 5)
print(IntersectionRange(c, d).doesIntersect())
print(IntersectionRange(d, c).doesIntersect())

/**
 x1x2  y1    y2
 1 3   5     10
 |-----|
   |---------|
 */
