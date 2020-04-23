import Foundation
import UIKit

/**
 Create an image-fetcher that handles fetches of images when given URLs.
 You are given two objects to use in your implementation:
 1. A cache to store the image in memory.
 2. A url-request-client to request images.
 Assume that these two objects are already implemented.

 Your image fetcher must handle repeated fetches for the same URL such that the
 url-request-client is not called more than necessary.

 Note: Everything should be on the main thread.
 */

/// URL Request client (given)

protocol DBImageURLRequestClientDelegate: class {
    func didDownloadImage(_ image: UIImage, forURL url: URL)
}

class DBImageURLRequestClient {
    weak var delegate: DBImageURLRequestClientDelegate?
    init () {}
    func downloadImage(atURL url: URL) {}
}

/// Cache (given)
class DBImageCache<Key: Hashable> {
    init() {}
    func setImage(_ image: UIImage, forKey key: Key) {}
    func image(forKey key: Key) -> UIImage? { return UIImage() }
}

















/// Image Fetcher (please implement)
public class DBImageFetcher: DBImageURLRequestClientDelegate {
    public typealias DBImageFetcherBlock = (UIImage) -> ()
    public static let sharedInstance = DBImageFetcher()

    private let client = DBImageURLRequestClient()
    private let cache = DBImageCache<URL>()
    private let kMaxConcurrent = 5

    private var seen = Set<String>()
    private var lookup: [String: [DBImageFetcherBlock]] = [:]
    private var semaphore: DispatchSemaphore
    private let downloadQueue = DispatchQueue(label: "com.downloadQueue", attributes: .concurrent)

    private init() {
        semaphore = DispatchSemaphore(value: kMaxConcurrent)
        client.delegate = self
    }

    public func fetchImageForURL(url: URL, onSuccess: @escaping DBImageFetcherBlock) {
        if let cachedImage = cache.image(forKey: url) {
            onSuccess(cachedImage)
            return
        }

        if seen.contains(url.absoluteString) {
            lookup[url.absoluteString, default: []].append(onSuccess)
        } else {
            downloadQueue.async {
                self.semaphore.wait()
                self.client.downloadImage(atURL: url)
            }

            lookup[url.absoluteString, default: []].append(onSuccess)
        }
    }

    public func didDownloadImage(_ image: UIImage, forURL url: URL) {
        cache.setImage(image, forKey: url)
        semaphore.signal()

        lookup[url.absoluteString]?.forEach { callback in
            callback(image)
        }

        // Flush out the cache of callbacks
        lookup[url.absoluteString] = []
    }
}


