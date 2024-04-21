import UIKit

final class LoadableImageView: UIImageView {

    // MARK: - Public Property

    var url: URL? {
        didSet {
            guard let url, url != oldValue else { return }
            loadImage(url)
        }
    }

    // MARK: - Private Property

    private let loadingQueue = DispatchQueue(
        label: "loadableImageView.loadImage",
        qos: .utility,
        attributes: .concurrent
    )

    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()

    private var dataTask: URLSessionDataTask?

    // MARK: - Private func

    private func loadImage(_ url: URL) {
        let request = URLRequest(url: url)

        // Check if the image is cached
        if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            self.image = image
            return
        }

        // If the image is not cached, load from the network
        dataTask?.cancel()

        // Use loadingQueue to call the image loading
        loadingQueue.async {
            self.dataTask = self.urlSession.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = UIImage(systemName: "dollarsign.arrow.circlepath")
                    }
                    return
                }

                guard
                    let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode),
                    let data = data else {
                    DispatchQueue.main.async {
                        self.image = UIImage(systemName: "dollarsign.arrow.circlepath")
                    }
                    return
                }

                // Cache the loaded image
                let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
                self.urlSession.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)

                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }

            self.dataTask?.resume()
        }
    }
}
