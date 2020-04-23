import Foundation

protocol DownloadListener: class {
    func onDownloadStart(id: String)
    func onDownloadEnd(id: String, success: Bool, sizeInBytes: Int)
}

class Downloader {
    func addListener(listener: DownloadListener) {
        // ...
    }
}

class BandwidthEstimator: DownloadListener {

    var timeLookup: [String: TimeInterval] = [:]
    var speedLookup: [String: Double] = [:]

    var avgMBPerSecond: Double {
        guard speedLookup.values.count > 0 else {
            return 0
        }

        return speedLookup.values.reduce(0, +) / Double(speedLookup.values.count)
    }

    func onDownloadStart(id: String) {
        timeLookup[id] = Date().timeIntervalSince1970
    }

    // 1024b -> 1kb -> 0.001mb
    func onDownloadEnd(id: String, success: Bool, sizeInBytes: Int) {
        let completionTime = Date().timeIntervalSince1970

        if success && sizeInBytes > 0 {
            let diff = completionTime - timeLookup[id]!
            timeLookup[id]! = diff

            let mb = Double(sizeInBytes) / 1000000

            speedLookup[id, default: 0] = mb / Double(timeLookup[id]!)
        }
    }

}

var bw = BandwidthEstimator()
bw.onDownloadStart(id: "a")
sleep(5)
bw.onDownloadEnd(id: "a", success: true, sizeInBytes: 1000000 * 10)
print(abs(bw.avgMBPerSecond - 2) < 0.03)

bw = BandwidthEstimator()
print(bw.avgMBPerSecond == 0)

bw = BandwidthEstimator()
bw.onDownloadStart(id: "a")
sleep(2)
bw.onDownloadEnd(id: "a", success: true, sizeInBytes: 1000000 * 1)

bw.onDownloadStart(id: "b")
sleep(2)
bw.onDownloadEnd(id: "b", success: true, sizeInBytes: 1000000 * 10)
print(abs(bw.avgMBPerSecond - 2.75) < 0.03)
