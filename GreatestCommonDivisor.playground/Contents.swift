/**
 The greatest common divisor (or Greatest Common Factor) of two numbers a and b is
 the largest positive integer that divides both a and b without a remainder.
 */

class GCD {
    /**
     The laborious way of calculating the GCD of two numbers is to figure out the factors of both numbers, and
     take the greatest number they have in common. The problem is that factoring large numbers is computationally
     expensive (like, VERY VERY expensive). So expensive that we rely on that constraint to keep our online payments
     secure. The most well-known method is to use Euclid's algorithm: `gcd(a, b) = gcd(b, a % b)`.
     */
    func iterative(m: Int, n: Int) -> Int {
        var a: Int = 0
        var b: Int = max(m, n)
        var remainder: Int = min(m, n)

        while remainder != 0 {
            a = b
            b = remainder

            remainder = a % b
        }

        return b
    }

    /**
     gcd(3819, 51357 % 3819) = gcd(3819, 1710), so:
     gcd(3819, 1710) = gcd(1710, 3819 % 1710)   =
     gcd(1710, 399)  = gcd(399, 1710 % 399)     =
     gcd(399, 114)   = gcd(114, 399 % 114)      =
     gcd(114, 57)    = gcd(57, 114 % 57)        =
     gcd(57, 0)                                 = 57
     */
    func recursive(m: Int, n: Int) -> Int {
        let remainder: Int = m % n

        if remainder != 0 {
            return recursive(m: n, n: remainder)
        } else {
            return n
        }
    }
}

print(GCD().iterative(m: 52, n: 39))        // 13
print(GCD().iterative(m: 228, n: 36))       // 12
print(GCD().iterative(m: 51357, n: 3819))   // 57

print(GCD().recursive(m: 51357, n: 3819))
