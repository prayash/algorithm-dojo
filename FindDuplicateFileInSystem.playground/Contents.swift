import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

func md5(_ string: String) -> Data {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    let messageData = string.data(using:.utf8)!
    var digestData = Data(count: length)

    _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
        messageData.withUnsafeBytes { messageBytes -> UInt8 in
            if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                let messageLength = CC_LONG(messageData.count)
                CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
            }
            return 0
        }
    }
    return digestData
}

/**
 Given a list of directory info including directory path, and all the files with contents in this directory, you need to find out all the groups of duplicate files in the file system in terms of their paths.

 A group of duplicate files consists of at least two files that have exactly the same content.

 A single directory info string in the input list has the following format:

 "root/d1/d2/.../dm f1.txt(f1_content) f2.txt(f2_content) ... fn.txt(fn_content)"

 It means there are n files (f1.txt, f2.txt ... fn.txt with content f1_content, f2_content ... fn_content, respectively) in directory root/d1/d2/.../dm. Note that n >= 1 and m >= 0. If m = 0, it means the directory is just the root directory.

 The output is a list of group of duplicate file paths. For each group, it contains all the file paths of the files that have the same content. A file path is a string that has the following format:

 "directory_path/file_name.txt"

 Example 1:

 Input:
 ["root/a 1.txt(abcd) 2.txt(efgh)", "root/c 3.txt(abcd)", "root/c/d 4.txt(efgh)", "root 4.txt(efgh)"]
 Output:
 [["root/a/2.txt","root/c/d/4.txt","root/4.txt"],["root/a/1.txt","root/c/3.txt"]]

 Follow-up beyond contest:
 Imagine you are given a real file system, how will you search files? DFS or BFS?
 If the file content is very large (GB level), how will you modify your solution?
 If you can only read the file by 1kb each time, how will you modify your solution?
 What is the time complexity of your modified solution? What is the most time-consuming part and memory consuming part of it? How to optimize?
 How to make sure the duplicated files you find are not false positive?
 */
class Solution {
    func findDuplicate(_ paths: [String]) -> [[String]] {
        var store: [String: [String]] = [:]
        var result = [[String]]()
        guard paths.count > 0 else {
            return result
        }

        for dirInfo in paths {
            let components = dirInfo.split(separator: " ")

            for i in 1..<components.count {
                let root = components[0]
                let content = getContent(components[i])
                let hash = md5(content).map { String(format: "%02hhx", $0) }.joined()
                let fileName = extractFileName(components[i])
                let filePath = "\(root)/\(fileName)"

                store[hash, default: []].append(filePath)
            }
        }

        print(store.description)

        store.values.forEach {
            if $0.count > 1 {
                result.append($0)
            }
        }

        return result
    }

    private func extractFileName(_ str: String.SubSequence) -> String {
        let idxOfDelimiter = str.firstIndex(of: "(")!

        return String(str[..<idxOfDelimiter])
    }

    private func getContent(_ str: String.SubSequence) -> String {
        let beginIndex = str.firstIndex(of: "(")!
        let endIndex = str.firstIndex(of: ")")!

        return String(str[str.index(after: beginIndex)..<endIndex])
    }
}

print(Solution().findDuplicate(["root/a 1.txt(abcd) 2.txt(efgh)", "root/c 3.txt(abcd)", "root/c/d 4.txt(efgh)", "root 4.txt(efgh)"]))
print(Solution().findDuplicate(["root/a 1.txt(abcd) 2.txt(efsfgh)","root/c 3.txt(abdfcd)","root/c/d 4.txt(efggdfh)"]))
