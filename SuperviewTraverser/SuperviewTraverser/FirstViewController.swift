import UIKit

/**
Given an arbitrary set of 2 or more views (UIView), I want to determine what is the (closest) common parent for those views.
What is the most efficient algorithm for this in Swift?
Based on these hierarchies:

                            ┌─────┐
                            │  A  │
                            └─────┘
                               ▲
                  ┌────────────┴────────────┐
                  │                         │
               ┌─────┐                   ┌─────┐                ┌─────┐
               │  B  │                   │  C  │                │  X  │
               └─────┘                   └─────┘                └─────┘
                  ▲                         ▲                      ▲
           ┌──────┴──────┐           ┌──────┴──────┐               │
           │             │           │             │               │
        ┌─────┐       ┌─────┐     ┌─────┐       ┌─────┐         ┌─────┐       ┌─────┐
        │  D  │       │  E  │     │  F  │       │  G  │         │  Y  │       │  Z  │
        └─────┘       └─────┘     └─────┘       └─────┘         └─────┘       └─────┘
- If no views provided, return nil.
- If 1 view provided, return superview or nil.
- If any view does not have a superview (e.g. "A", "X" or "Z"), return nil.
- If views do not belong to the same hierarchy (e.g. "A" or "X" hierarchy), return nil.
*/
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewD = UIView()
        viewD.accessibilityIdentifier = "D"

        let viewE = UIView()
        viewE.accessibilityIdentifier = "E"

        let viewB = UIView()
        viewB.accessibilityIdentifier = "B"
        viewB.addSubview(viewD)
        viewB.addSubview(viewE)

        let viewC = UIView()
        viewC.accessibilityIdentifier = "C"

        let viewA = UIView()
        viewA.accessibilityIdentifier = "A"
        viewA.addSubview(viewB)
        viewA.addSubview(viewC)

        view.addSubview(viewA)

         ViewTraverser.traverseSuperViews(view: viewE).forEach { print($0) }

        commonSuperviews(between: viewD, and: viewE).forEach {
            print("Using commonSuperviews(): \($0) \($0.accessibilityIdentifier ?? "None")")
        }

        print("Using commonParent(D, E): \([viewD, viewE].commonParent()?.accessibilityIdentifier ?? "None")")
        print("Using commonParent(B, C): \([viewB, viewC].commonParent()?.accessibilityIdentifier ?? "None")")
    }

}

func commonSuperviews(between lhs: UIView, and rhs: UIView) -> [UIView] {
    func getSuperviews(for view: UIView) -> [UIView] {
        guard let superview = view.superview else { return [] }

        return [superview] + getSuperviews(for: superview)
    }

    let leftSuperviews = getSuperviews(for: lhs)
    let rightSuperviews = getSuperviews(for: rhs)

    return Array(Set(leftSuperviews).intersection(Set(rightSuperviews)))
}

extension Collection where Iterator.Element: UIView {
    func commonParent() -> UIView? {
        // Must be at least 1 view
        guard let firstView = self.first else {
            return nil
        }

        // If only 1 view, return it's superview, or nil if already root
        guard self.count > 1 else {
            return firstView.superview
        }

        // Find the common parent
        var superview = firstView.superview
        while superview != nil {
            if self.reduce(true, { $1.isDescendant(of: superview!) && $1 != superview! }) {
                // If all views are descendent of superview return common parent
                return superview
            } else {
                // else go to next superview and test that
                superview = superview?.superview
            }
        }

        // else, there is no common parent
        return nil
    }
}

class ViewTraverser {
    typealias ViewMap = [String: UIView]

    static func traverseSuperViews(view: UIView) -> ViewMap {
        var views: [String: UIView] = [:]
        var inputView: UIView? = view

        while inputView != nil {
            guard let accessibilityIdentifier = inputView?.accessibilityIdentifier, let view = inputView else { break }

            views[accessibilityIdentifier] = view
            inputView = view.superview
        }

        return views
    }

    private func checkForSuper(view: UIView?, views: ViewMap) -> UIView? {
        guard let view = view else { return nil }

        if views[view.accessibilityIdentifier!] != nil {
            return view
        }

        return nil
    }
}
