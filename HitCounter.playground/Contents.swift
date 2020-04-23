/**
 Design a hit counter which counts the number of hits received in the past 5 minutes.
 Each function accepts a timestamp parameter (in seconds granularity) and you may assume that
 calls are being made to the system in chronological order (ie, the timestamp is monotonically increasing).
 You may assume that the earliest timestamp starts at 1.
 It is possible that several hits arrive roughly at the same time.

     HitCounter counter = new HitCounter();

     // hit at timestamp 1.
     counter.hit(1);

     // hit at timestamp 2.
     counter.hit(2);

     // hit at timestamp 3.
     counter.hit(3);

     // get hits at timestamp 4, should return 3.
     counter.getHits(4);

     // hit at timestamp 300.
     counter.hit(300);

     // get hits at timestamp 300, should return 4.
     counter.getHits(300);

     // get hits at timestamp 301, should return 3.
     counter.getHits(301);
 */
class HitCounter {

    var hits: [Int: Int] = [:]

    func hit(_ timestamp: Int) {
        hits[timestamp, default: 0] += 1
    }

    func getHits(_ timestamp: Int) -> Int {
        var total = 0
        let start = timestamp - 299
        for t in start...timestamp {
            if let hit = hits[t] {
                total += hit
            }
        }

        return total
    }
}

/**
 * Your HitCounter object will be instantiated and called as such:
 * let obj = HitCounter()
 * obj.hit(timestamp)
 * let ret_2: Int = obj.getHits(timestamp)
 */
