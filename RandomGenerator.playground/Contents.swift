/**
 * Given a function magicNumber() that returns a random integer 1 or 0, write a
 * new function that will generate a random number that uses this magicNumber() function.
 */

class RandomGenerator {
    func magicNumber() -> Int {
        return Int.random(in: 0...1)
    }

    func randomNumber() -> Int {
        var number = 0
        for bit in 0..<Int32.bitWidth {
            if magicNumber() == 1 {
                number += (1 << bit)
            }
        }

        return number
    }
}

let randomGenerator = RandomGenerator()
print(randomGenerator.randomNumber())
