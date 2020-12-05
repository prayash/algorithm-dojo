import Foundation

typealias Queue = [Double]

/// Whenever you expose a web service / API endpoint, you need to implement a rate limiter to
/// prevent abuse of the service (DOS attacks).
/// Implement a RateLimiter Class with an isAllow method. Every request comes in with a
/// unique `clientID`, deny a request if that client has made more than 100 requests in the past second.
///
/// The Tocket Bucket algorithm is based on an analogy of a fixed capacity bucket into which tokens
/// are added at a fixed rate. Before allowing an API to proceed, the bucket is inspected to see if
/// it contains at least 1 token at that time. If so, one token is removed from the bucket, and the
/// request is fulfilled. In case there are no tokens available, the request is rejected, given that
/// the quota has exceeded during that window.
/// https://leetcode.com/discuss/interview-question/124558/Implement-a-Rate-Limiter/
///
public final class RateLimiter {
    
    private var capacity: Int
    
    private var windowTimeInSeconds: Double

    private var timestampTable: [String: Queue] = [:]
    
    init(capacity: Int = 100, windowTimeInSeconds: Double) {
        self.capacity = capacity
        self.windowTimeInSeconds = windowTimeInSeconds
    }
    
    func isAllowed(clientId: String) -> Bool {
        let now = Date().timeIntervalSince1970
        
        // If it's a first time request, let em through.
        guard let timestamps = timestampTable[clientId] else {
            timestampTable[clientId, default: []].append(now)
            return true
        }
        
        // We've hit capacity. Pop the last timestamp off the queue.
        if timestamps.count >= capacity, let latest = timestamps.first {
            let elapsedTimeSinceLastRequest = now - latest
            timestampTable[clientId]?.removeFirst()
            timestampTable[clientId, default: []].append(now)
            
            if elapsedTimeSinceLastRequest < windowTimeInSeconds {
                return false
            }
        } else {
            timestampTable[clientId, default: []].append(now)
        }
        
        return true
    }
}

