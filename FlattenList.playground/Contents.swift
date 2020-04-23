/**
 Flatten a list containing n sublists.
 Like so: [3, 4, [4, [[55]]]] -> [3, 4, 4, 55]
 */

class Solution {
    func flatten(_ list: [Any]) -> [Any] {
        var result = [Any]()

        for element in list {
            guard let num = element as? Int else {
                result += flatten(element as! [Any])
                continue
            }

            result.append(num)
        }

        return result
    }
}

var list = [3, 4, [4, [[55]]]] as [Any]
print(Solution().flatten(list))
