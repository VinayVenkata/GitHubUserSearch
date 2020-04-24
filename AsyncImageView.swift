import Kingfisher

class AsyncImageView: UIImageView {

	func setImageWith(url: URL?, placeholder: UIImage? = #imageLiteral(resourceName: "loading_thumbnail"), indicatorType: IndicatorType?  = nil, completion: (() -> Void)? = nil) {
		guard let url = url else {
			self.image = fallbackImage
			return
		}

		let resource = ImageResource(downloadURL: url)
		self.url = url
		kf.indicatorType = indicatorType ?? .none
		kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.25))], progressBlock: nil) { [weak self] _, error, _, _ in
			switch error {
			case .none: break
			case .some(let error):
				print(error)
				self?.url = nil
				self?.image = self?.fallbackImage
			}
			completion?()
		}
	}

	func setImageWith(url: URL?, placeholder: UIImage? = #imageLiteral(resourceName: "loading_thumbnail"), indicatorType: IndicatorType?  = nil, success: (() -> Void)? = nil, failure: ((_ error: NSError?) -> Void)? = nil) {
		guard let url = url else {
			return
		}

		let resource = ImageResource(downloadURL: url)
		self.url = url
		kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(0.25))], progressBlock: nil) { [weak self] _, error, _, _ in
			switch error {
			case .none: break
			case .some(let error):
				self?.url = nil
				failure?(error)
				break
			}
			success?()
		}
	}

	func reset() {
		kf.cancelDownloadTask()
		self.image = nil
		self.url = nil
	}

	lazy var fallbackImage: UIImage? = {
		let bundle = Bundle(for: AsyncImageView.self)
		return UIImage(named: "failedLoad", in: bundle, compatibleWith: nil)
	}()

	var url: URL?
	private static let shared: AsyncImageView = AsyncImageView()

	static func saveImageToCache(url: URL?, completion: ((NSError?) -> Void)? = nil) {
		if completion != nil {
			shared.setImageWith(url: url, placeholder: nil, indicatorType: nil, success: {
				completion!(nil)
			}, failure: { (error) in
				completion!(error)
			})
		} else {
			shared.setImageWith(url: url)
		}
	}
}
