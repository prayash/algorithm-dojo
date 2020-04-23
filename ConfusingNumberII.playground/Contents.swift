/**
 We can rotate digits by 180 degrees to form new digits. When 0, 1, 6, 8, 9 are rotated 180 degrees,
 they become 0, 1, 9, 8, 6 respectively. When 2, 3, 4, 5 and 7 are rotated 180 degrees, they become invalid.

 A confusing number is a number that when rotated 180 degrees becomes a different number with each
 digit valid. (Note that the rotated number can be greater than the original number.)

 Given a positive integer N, return the number of confusing numbers between 1 and N inclusive.

 Input: 20
 Output: 6
 Explanation:
 The confusing numbers are [6,9,10,16,18,19].
 6 converts to 9.
 9 converts to 6.
 10 converts to 01 which is just 1.
 16 converts to 91.
 18 converts to 81.
 19 converts to 61.
 */
class Solution {
    /**
      Generate all numbers that are less than N and check whether they are a confusing number or not
     */
    func confusingNumberII(_ N: Int) -> Int {
        var count = 0
        dfs(0, &count, N)
        return count
    }

    func dfs(_ start: Int, _ count: inout Int, _ N: Int) {
        let num = [0, 1, 6, 8, 9]

        // We've exceeded the bound
        if start > N {
            return
        }

        if isConfusing(start) {
            count += 1
        }

        for i in (start == 0 ? 1 : 0)..<5 {
            dfs(start * 10 + num[i], &count, N)
        }
    }

    func isConfusing(_ num: Int) -> Bool {
        let map: [Int: Int] = [
            0: 0,
            1: 1,
            6: 9,
            8: 8,
            9: 6
        ]

        var res = 0
        var n = num

        while n > 0 {
            let num = n % 10

            // If the number can be rotated, do so.
            if let digit = map[num] {
                res = res * 10 + digit
                n = n / 10
            }
        }

        return res != num

    }
}

print(Solution().confusingNumberII(20))
print(Solution().confusingNumberII(100))


func confusingNumber(_ N: Int) -> Bool {
    let map: [Int: Int] = [
        0: 0,
        1: 1,
        6: 9,
        8: 8,
        9: 6
    ]

    var num = N
    var res = 0

    while num > 0 {
        let digit = num % 10

        if let rotatedDigit = map[digit] {
            res = res * 10 + rotatedDigit
            num = num / 10
        } else {
            return false
        }
    }

    return res != N
}

print(confusingNumber(11))
print(confusingNumber(25))
