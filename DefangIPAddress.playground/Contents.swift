/**
 Given a valid (IPv4) IP address, return a defanged version of that IP address.
 A defanged IP address replaces every period "." with "[.]".

 Input: address = "255.100.50.0"
 Output: "255[.]100[.]50[.]0"
 */

class Solution {
    func defangIPaddr(_ address: String) -> String {
        var result = ""

        for char in address {
            result += String(char) == "." ? "[.]" : String(char)
        }

        return result
    }
}

print(Solution().defangIPaddr("255.100.50.0"))
