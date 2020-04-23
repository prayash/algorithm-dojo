/**
 Suppose we abstract our file system by a string in the following manner:
 The string
 "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
 represents:
     dir
         subdir1
             file1.ext
             subsubdir1
         subdir2
             subsubdir2
                 file2.ext

 We are interested in finding the longest (number of characters) absolute path to a
 file within our file system. For example, in the second example above, the longest
 absolute path is "dir/subdir2/subsubdir2/file2.ext", and its length is 32
 (not including the double quotes).

 Given a string representing the file system in the above format, return the length
 of the longest absolute path to file in the abstracted file system. If there is
 no file in the system, return 0.

 Time complexity required: O(n) where n is the size of the input string.

 Notice that a/aa/aaa/file1.txt is not the longest file path, if there is another
 path aaaaaaaaaaaaaaaaaaaaa/sth.png.
 */

class Solution {
    func lengthLongestPath(_ input: String) -> Int {
        var dirPathLengths = [Int]()
        var maxLength = 0

        // Scan line by line
        for line in input.split(separator: "\n") {
            let isFile = line.contains(".")
            let levels = line.split(separator: "\t", omittingEmptySubsequences: false)
            var dirLength = 0

            for (depth, dirLevel) in levels.enumerated() {
                let isPathComponentFile = dirLevel.contains(".")

                if !dirLevel.isEmpty && !isFile {
                    if depth < dirPathLengths.count {
                        dirPathLengths[depth] = dirLevel.count

                    } else {
                        dirPathLengths.append(dirLevel.count)
                    }
                }

                if isFile {
                    dirLength += isPathComponentFile ? line.count : dirPathLengths[depth]
                }
            }

            maxLength = max(maxLength, dirLength)
        }

        return maxLength
    }
}

var input = "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
print(Solution().lengthLongestPath(input))
