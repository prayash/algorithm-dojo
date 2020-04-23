func insertionSort(_ array: [Int]) -> [Int] {
    var a = array

    for i in 1..<a.count {
        var j = i
        let temp = a[j]

        while j > 0 && a[j - 1] > temp {
            a[j] = a[j - 1]
            j -= 1
        }

        a[j] = temp
    }

    return a
}

let x = [8, 4, 1, 9, 5, 2]
print(insertionSort(x))

func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var a = array

    for i in 1..<a.count {
        var j = i
        let temp = a[j]

        while j > 0 && isOrderedBefore(a[j - 1], temp) {
            a[j] = a[j - 1]
            j -= 1
        }

        a[j] = temp
    }

    return a
}

print(insertionSort(x, >))
