import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let scrollView = UIScrollView()
        let label1 = UILabel()
        let label2 = UILabel()
        scrollView.addSubview(label1)
        scrollView.addSubview(label2)

        // 2
        let tableView = UITableView()
        let imageView = UIImageView()
        tableView.addSubview(imageView)

        // 3
        let view = UIView(frame: CGRect(x: 0, y: 10, width: 100, height: 500))
        view.addSubview(scrollView)
        view.addSubview(tableView)

        // We'll model this function manually
        // print(view.perform(Selector(("recursiveDescription")))!)
//        print(view.recursiveDescription())
        print("DFS Hierarchy: \n")
        print(view.hierarchyDFS())
        print("\nBFS Hierarchy: \n")
        print(view.hierarchyBFS())
    }

}

extension UIView {
    /**
     This is a private Obj-C API, but will give us a DFS traversal of the views.
     It will visit each subview and all its children before exploring other subviews.
     We'll model `view.perform(Selector(("recursiveDescription")))` manually.

     `recursiveDescription` is a private function on UIView that prints the description
     of the view and all its subviews (or children views).

                   [ view ]
                  /        \
          [scrollView]    [tableView]
           /        \          \
       [label1]   [label2]   [imageView]
    */
    func recursiveDescription() -> String {
        return dfsHelper(with: "")
    }

    func dfsHelper(with prefix: String) -> String {
        // DFS recursion base case: explore children until we hit a leaf node.
        guard !subviews.isEmpty else {
            return description
        }

        var text: String = description
        let nextPrefix: String = prefix + "  |  "

        // For each node, explore all its children
        for view in subviews {
            text.append("\n")
            text.append(nextPrefix)
            text.append(view.dfsHelper(with: nextPrefix))
        }

        return text
    }
}

extension UIView {
    func hierarchyDFS(withPrefix: String = "") -> String {
        guard !subviews.isEmpty else {
            return String(description.prefix(75))
        }

        var text = String(description.prefix(75))
        let nextPrefix = withPrefix + "  |  "

        for sv in subviews {
            text.append("\n")
            text.append(nextPrefix)
            text.append(sv.hierarchyDFS(withPrefix: nextPrefix))
        }

        return text
    }

    func hierarchyBFS() -> String {
        var bfsQueue: [UIView] = [self]
        var result = ""
        var depth = 0

        while !bfsQueue.isEmpty {
            for _ in 0..<bfsQueue.count {
                let node = bfsQueue.removeFirst()

                result.append(depth == 0 ? "" : "\n")
                result.append(depth == 0 ? "" : String.init(repeating: "  |  ", count: depth))
                result.append(String(node.description.prefix(75)))

                if !subviews.isEmpty {
                    for sv in node.subviews {
                        bfsQueue.append(sv)
                    }
                }
            }

            depth += 1
        }

        return result
    }
}
