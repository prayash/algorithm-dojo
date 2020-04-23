import Foundation

/**
 The area of a circle is defined as r^2.
 Estimate pi to 3 decimal places using Monte Carlo simulation.
 Hint: The basic equation of a circle is x^2 + y^2 = r^2.
 */

class Solution {
    func estimatePi(iterations: Int, radius: Double = 2.0) -> Double {
        var inner: Int = 0
        let rSquared: Double = pow(radius, 2.0)

        for _ in 0...iterations {
            // Randomly generated x and y values
            let xRand = Double.random(in: 0...radius)
            let yRand = Double.random(in: 0...radius)

            // If (x, y) lies within the defined circle
            if pow(xRand, 2.0) + pow(yRand, 2.0) < rSquared {
                inner += 1
            }
        }

        // Pi estimation after all iterations
        // PI/4 = approx. N of inner / N of iterations
        // Therefore, PI = 4 * inner / iterations
        return 4 * Double(inner) / Double(iterations)
    }
}

// print(Solution().estimatePi(iterations: 100000)) // => 3.14192
