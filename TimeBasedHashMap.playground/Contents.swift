/**
 Create a timebased key-value store class TimeMap, that supports two operations.
 1. set(string key, string value, int timestamp)
 Stores the key and value, along with the given timestamp.

 2. get(string key, int timestamp)
 Returns a value such that set(key, value, timestamp_prev) was called previously, with
 timestamp_prev LTE to timestamp.

 If there are multiple such values, it returns the one with the largest timestamp_prev.
 If there are no values, it returns the empty string ("").
 */

class TimeMap {

    private var timestamps: [String: [Int]] = [:]
    private var values: [Int: String] = [:]

    func set(_ key: String, _ value: String, _ timestamp: Int) {
        timestamps[key, default: []].append(timestamp)
        values[timestamp] = value
    }

    func get(_ key: String, _ timestamp: Int) -> String {
        guard let array = timestamps[key] else { return "" }
        guard let first = array.first, timestamp >= first else { return "" }

        let timeKey = binarySearch(array, timestamp)
        return values[timeKey] ?? ""
    }

    private func binarySearch(_ array: [Int], _ target: Int) -> Int {
        var left = 0
        var right = array.count - 1

        while left < right {
            let mid = left + (right - left) / 2

            if array[mid] == target {
                return target
            } else if target < array[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }

        return array[left]
    }
}
/**
 * Your TimeMap object will be instantiated and called as such:
 * let obj = TimeMap()
 * obj.set(key, value, timestamp)
 * let ret_2: String = obj.get(key, timestamp)
 */

let tm = TimeMap()
tm.set("love", "high", 10)
tm.set("love", "low", 20)
tm.get("love", 5)
tm.get("love", 10)
tm.get("love", 15)
tm.get("love", 20)
tm.get("love", 25)
