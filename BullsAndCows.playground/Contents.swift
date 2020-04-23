/**
 You are playing the following Bulls and Cows game with your friend: You write down a number
 and ask your friend to guess what the number is. Each time your friend makes a guess, you
 provide a hint that indicates how many digits in said guess match your secret number exactly
 in both digit and position (called "bulls") and how many digits match the secret number but
 locate in the wrong position (called "cows"). Your friend will use successive guesses and
 hints to eventually derive the secret number.

 Write a function to return a hint according to the secret number and friend's guess, us
 A to indicate the bulls and B to indicate the cows.

 Please note that both secret number and friend's guess may contain duplicate digits.

 Input: secret = "1807", guess = "7810"
 Output: "1A3B"
 Explanation: 1 bull and 3 cows. The bull is 8, the cows are 0, 1 and 7.
 */

class Solution {
    func getHint(_ secret: String, _ guess: String) -> String {
        var bulls = 0
        var cows = 0
        var hashMap: [Character : Int] = [:]

        for (index, secretChar) in secret.enumerated() {
            let guessChar = Array(guess)[index]

            if secretChar == guessChar  {
                bulls += 1
            } else {
                if hashMap[secretChar, default: 0] < 0 {
                    cows += 1
                }

                if hashMap[guessChar, default: 0] > 0 {
                    cows += 1
                }

                hashMap[secretChar, default: 0] += 1
                hashMap[guessChar, default: 0] -= 1
            }
        }

        return "\(bulls)A\(cows)B"
    }
}

var secret = "1807", guess = "7810"
print(Solution().getHint(secret, guess))

secret = "1123"
guess = "0111"
print(Solution().getHint(secret, guess))
