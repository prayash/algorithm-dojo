/**
 A character in UTF8 can be from 1 to 4 bytes long, subjected to the following rules:

 For 1-byte character, the first bit is a 0, followed by its unicode code.
 For n-bytes character, the first n-bits are all one's, the n+1 bit is 0, followed by n-1
 bytes with most significant 2 bits being 10.

 This is how the UTF-8 encoding would work:

    Char. number range  |        UTF-8 octet sequence
       (hexadecimal)    |              (binary)
    --------------------+---------------------------------------------
    0000 0000-0000 007F | 0xxxxxxx
    0000 0080-0000 07FF | 110xxxxx 10xxxxxx
    0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
    0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

 Given an array of integers representing the data, return whether it is a valid utf-8 encoding.
 The input is an array of integers. Only the least significant 8 bits of each integer is used to
 store the data. This means each integer represents only 1 byte of data.

 data = [197, 130, 1], which represents the octet sequence: 11000101 10000010 00000001.
 Return true. It is a valid utf-8 encoding for a 2-bytes character followed by a 1-byte character.

 data = [235, 140, 4], which represented the octet sequence: 11101011 10001100 00000100.
 Return false. The first 3 bits are all one's and the 4th bit is 0 means it is a 3-bytes character.

 The next byte is a continuation byte which starts with 10 and that's correct.
 But the second continuation byte does not start with 10, so it is invalid.
 */

class Solution {
    func validUtf8(_ data: [Int]) -> Bool {
        var numOfBytesToProcess = 0

        for i in 0..<data.count {
            var binary = String(data[i], radix: 2, uppercase: false)

            // Grab 8 least significant bits or pad with 0's on left hand side
            binary = binary.count >= 8
                ? String(binary.prefix(8))
                : String(repeating: "0", count: 8 - binary.count) + binary

            // If this is the case then we are to start processing a new UTF-8 character.
            if numOfBytesToProcess == 0 {
                // Get the number of 1s in the beginning of the string.
                for char in binary {
                    if char == "0" {
                        break
                    }

                    numOfBytesToProcess += 1
                }

                // 1 byte characters
                if numOfBytesToProcess == 0 {
                    continue
                }

                // Invalid scenarios according to the rules of the problem.
                if numOfBytesToProcess > 4 || numOfBytesToProcess == 1 {
                    return false
                }
            } else {
                // Else, we are processing integers which represent bytes which are a part of
                // a UTF-8 character. So, they must adhere to the pattern `10xxxxxx`.
                if !(Array(binary)[0] == "1" && Array(binary)[1] == "0") {
                    return false
                }
            }

            // We reduce the number of bytes to process by 1 after each integer.
            numOfBytesToProcess -= 1
        }

        // This is for the case where we might not have the complete data for
        // a particular UTF-8 character.
        return numOfBytesToProcess == 0
    }
}

var data = [197, 130, 1]
print(Solution().validUtf8(data))

data = [235, 140, 4]
print(Solution().validUtf8(data))
