// O(n ^ 2)
func selectionSort(_ arr: [Int]) -> [Int] {
    var result = arr

    for i in 0..<arr.count {
        // Assume the minimum is the first element
        var indexOfLowest = i

        // Test against all elements after i to find the smallest
        for j in i + 1..<arr.count {
            // If the new jth element is less, it's the new minimum
            // Store that index
            if result[j] < result[indexOfLowest] {
                indexOfLowest = j
            }
        }

        // Avoid swapping in the same place
        if i != indexOfLowest {
            result.swapAt(i, indexOfLowest)
        }
    }

    return result
}

let a = [22, 9, 12, 10, 3, 8, 2]
print(selectionSort(a))
