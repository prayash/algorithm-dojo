import UIKit

class ViewController: UICollectionViewController {

    private let cellId = "cell"
    var grid = [[Int]].init(repeating: [Int].init(repeating: 0, count: 9), count: 9)

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                grid[row][col] = Int(arc4random_uniform(UInt32(2)))
            }
        }

        print(grid)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.section
        let col = indexPath.item
        let searchState = grid[row][col]

        dfs(row: row, col: col, searchState: searchState)
        collectionView.reloadData()
    }

    private func dfs(row: Int, col: Int, searchState: Int) {
        print("Starting search at \(row) \(col) for \(searchState)")

        guard grid[row][col] == searchState else {
            return
        }

        grid[row][col] = grid[row][col] == 0 ? 1 : 0

        // right cell
        if (row >= 0 && row < grid.count) && (col + 1 >= 0 && col + 1 < grid[0].count) {
            dfs(row: row, col: col + 1, searchState: searchState)
        }

        // left cell recursive search
        if (row >= 0 && row < grid.count) && (col - 1 >= 0 && col - 1 < grid[0].count) {
            dfs(row: row, col: col - 1, searchState: searchState)
        }

        // down
        if (row + 1 >= 0 && row + 1 < grid.count) && (col >= 0 && col < grid[0].count) {
            dfs(row: row + 1, col: col, searchState: searchState)
        }

        // up
        if (row - 1 >= 0 && row - 1 < grid.count) && (col >= 0 && col < grid[0].count) {
            dfs(row: row - 1, col: col, searchState: searchState)
        }

//        let indexPath = IndexPath(item: col, section: row)
//        collectionView.reloadItems(at: [indexPath])

    }

}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid[section].count
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return grid.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let state = grid[indexPath.section][indexPath.item]

        cell.backgroundColor = state == 1 ? .systemBlue : .systemRed

        return cell
    }
}

// 0 -> red
// 1 -> blue

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 40, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 0, bottom: 0, right: 0)
    }
}
