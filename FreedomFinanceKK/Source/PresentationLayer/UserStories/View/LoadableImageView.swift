import UIKit
import Kingfisher

final class LoadableImageView: UIImageView {

    // MARK: - Public Property

    var url: URL? {
        didSet {
            guard let url, url != oldValue else { return }
            loadImage(url)
        }
    }

    // MARK: - Private func

    private func loadImage(_ url: URL) {
        kf.setImage(with: url, placeholder: image)
    }
}
