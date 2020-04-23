// ios-interviews@robinhood.com

import Foundation
import UIKit

struct Order: Equatable {

    let symbol: String
}

class NetworkManager {

    static let shared = NetworkManager()

    func sendOrder(order: Order, success: @escaping () -> Void, failure: @escaping () -> Void) {
        print("sendingOrder: \(order.symbol)")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            let rand = Int.random(in: 0...1)
            if rand == 0 {
                print("👍 Success: \(order.symbol)")
                success()
            } else {
                print("👎 Failure: \(order.symbol)")
                failure()
            }
        }
    }
}

class OrderManager {

    var attempts = 3
    var queue = [Order]()
    var isProcessing = false

    func placeOrder(_ order: Order) {
        queue.append(order)

        if !isProcessing {
            processQueue()
        }
    }

    private func processQueue() {
        guard let order = queue.first else {
            return
        }

        // Failure handling
        if attempts == 0 {
            queue.removeFirst()
            attempts = 3
            processQueue()
            return
        }

        isProcessing = true
        NetworkManager.shared.sendOrder(order: order, success: {
            // Remove it from the queue
            // Reset the attempt counter

            self.queue.removeFirst()
            self.attempts = 3
            self.isProcessing = false

            self.processQueue()
        }) {
            self.attempts -= 1
            self.processQueue()
        }
    }
}

let manager = OrderManager()
manager.placeOrder(Order(symbol: "AAPL"))
manager.placeOrder(Order(symbol: "GOOG"))
manager.placeOrder(Order(symbol: "UBER"))
