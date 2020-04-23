class Solution {
    func expand(_ expression: String) -> [String] {
        guard !expression.isEmpty else {
            return []
        }

        var sign: Character = "," // this is for the first one
        var stack = [[String]]()

        let charArray = Array(expression)
        var i = 0

        // sign will always default be *, unless we saw a ,
        while i < charArray.count {
            let c = charArray[i]

            if c.isLetter {
                // 2 conditions - might be right next to }, or might be a normal one after ,
                var list = [String(c)]
                if sign == "*" {
                    stack.append(product(stack.removeLast(), list))
                } else {
                    stack.append(list)
                }
                sign = "*"
            } else if c == "{" {
                var j = i + 1
                var count = 1

                while j < charArray.count && count != 0 {
                    if charArray[j] == "{" {
                        count += 1
                    } else if charArray[j] == "}" {
                        count -= 1
                    }

                    j += 1
                }

                let resList = expand(String(charArray[(i + 1)..<(j - 1)]))
                if sign == "*" {
                    stack.append(product(stack.removeLast(), resList))
                } else {
                    stack.append(resList)
                }
                sign = "*"

                i = j
                continue
            } else if c == "," {
                sign = ","
            }

            i += 1
        }

        var resSet = Set<String>()
        while !stack.isEmpty {
            let current = stack.removeLast()
            for s in current {
                resSet.insert(s)
            }
        }

        var res = Array(resSet)
        res.sort()

        return res
    }

    func product(_ list1: [String], _ list2: [String]) -> [String] {
        var res = [String]()
        for s1 in list1 {
            for s2 in list2 {
                res.append(s1 + s2)
            }
        }

        return res
    }
}

print(Solution().expand("{a,b,c}"))
