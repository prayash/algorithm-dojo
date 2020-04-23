import Foundation

/**
 Naive quicksort that abuses the built-in `filter` method. SUPERSLOW!
 */
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }

    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}

/**
 A faster quicksort which uses a more efficient partioning algorithm.
 */
func quickSort<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) {
    if low < high {
        let p = partition(&a, low, high)

        quickSort(&a, low, p - 1)
        quickSort(&a, p + 1, high)
    }
}

/**
 It may seem strange to use random numbers in something like a sorting function, but it
 is necessary to make quicksort behave efficiently under all circumstances. With bad
 pivots, the performance of quicksort can be quite horrible, O(n^2). But if you choose
 good pivots on average, for example by using a random number generator, the expected
 running time becomes O(n log n), which is as good as sorting algorithms get.
 */
func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = Int.random(in: low...high)

        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])

        let p = partition(&a, low, high)
        quicksortRandom(&a, low: low, high: p - 1)
        quicksortRandom(&a, low: p + 1, high: high)
    }
}

/**
 Lomuto's partitioning scheme.
 */
func partition<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> Int {
    let pivot = a[high]

    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }

    a.swapAt(i, high)
    return i
}

/**
 Hoare's partitioning scheme.
 */
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1

    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot

        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}

var list = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
quickSort(&list, 0, list.count - 1)
print(list)
