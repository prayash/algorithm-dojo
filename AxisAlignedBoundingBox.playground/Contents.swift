import Foundation
import UIKit

struct Point {
    let x: CGFloat
    let y: CGFloat
}

struct Rectangle: CustomStringConvertible {
    let topLeft: Point
    let bottomRight: Point

    var center: Point {
        let x = (self.topLeft.x + self.bottomRight.x) / 2
        let y = (self.topLeft.y + self.bottomRight.y) / 2

        return Point(x: x, y: y)
    }

    var description: String {
        return "Rectangle: topLeft: \(topLeft), bottomRight: \(bottomRight)"
    }
}

/// Bounding box computation that operates on a specific type of `Collection`
extension RandomAccessCollection where Iterator.Element == Point {
    var axisAlignedBoundingBox: Rectangle {
        precondition(self.count > 1, "Collection must have more than 1 point!")

        let minX: CGFloat = self.min { $0.x < $1.x }!.x
        let maxY: CGFloat = self.max { $0.y < $1.y }!.y
        let maxX: CGFloat = self.max { $0.x < $1.x }!.x
        let minY: CGFloat = self.min { $0.y < $1.y }!.y

        let topLeft = Point(x: minX, y: maxY)
        let bottomRight = Point(x: maxX, y: minY)

        return Rectangle(topLeft: topLeft, bottomRight: bottomRight)
    }
}

let points = [Point(x: -5, y: 0), Point(x: 4, y: 4), Point(x: -2, y: -3)]
let boundingBox = points.axisAlignedBoundingBox

// *** Test

print(boundingBox)
print(boundingBox.center)
