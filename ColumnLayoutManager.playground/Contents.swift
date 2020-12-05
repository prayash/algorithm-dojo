import Foundation
import UIKit

/// Provide an implementation for the following static method.
enum ColumnsLayoutManager {
    /// Lay the input views column by column. Place the child view on a new column
    /// if it does not fit within the current one. Throw an exception if the view placement
    /// fails.
    ///
    /// - Parameters:
    ///   - childViews: A collection of `UIView` objects.
    ///   - parentView: The target superview.
    /// - Throws: If the layout fails to fit all children within the parent superview.
    /// - Returns: A list of positions within the `parentView`.
    static func layout(childViews: [UIView], within parentView: UIView) throws -> [CGPoint] {
        let parentSize: CGSize = .init(width: parentView.frame.width, height: parentView.frame.height)
        var finalPositions: [CGPoint] = []
        
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        for child in childViews {
            if currentY + child.frame.height < parentSize.height {
                finalPositions.append(.init(x: currentX, y: currentY))
                currentY += child.frame.height
            } else {
                currentY = 0
                currentX += child.frame.width
            }
        }
        
        return finalPositions
    }
}
