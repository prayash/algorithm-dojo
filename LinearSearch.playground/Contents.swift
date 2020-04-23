func linearSearch<T: Equatable>(_ array: [T], _ target: T) -> Int? {
    for (index, element) in array.enumerated() where element == target {
        return index
    }

    return nil
}

let x = [5, 3, 9, 10, 24]
print(linearSearch(x, 10))
