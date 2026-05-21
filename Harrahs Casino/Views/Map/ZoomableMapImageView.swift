import SwiftUI
import UIKit

final class MapZoomScrollView: UIScrollView {
    var onBoundsChange: (() -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        onBoundsChange?()
    }
}

struct ZoomableMapImageView: UIViewRepresentable {
    let imageName: String
    let maxZoomMultiplier: CGFloat
    let resetTrigger: Int

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> MapZoomScrollView {
        let scrollView = MapZoomScrollView()
        scrollView.delegate = context.coordinator
        scrollView.bouncesZoom = true
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never

        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)

        context.coordinator.scrollView = scrollView
        context.coordinator.imageView = imageView
        context.coordinator.maxZoomMultiplier = maxZoomMultiplier
        context.coordinator.lastResetTrigger = resetTrigger

        scrollView.onBoundsChange = { [weak coordinator = context.coordinator, weak scrollView] in
            guard let scrollView, let coordinator else { return }
            coordinator.layoutImageIfNeeded(in: scrollView)
        }

        return scrollView
    }

    func updateUIView(_ scrollView: MapZoomScrollView, context: Context) {
        context.coordinator.maxZoomMultiplier = maxZoomMultiplier
        context.coordinator.layoutImageIfNeeded(in: scrollView)

        if context.coordinator.lastResetTrigger != resetTrigger {
            context.coordinator.lastResetTrigger = resetTrigger
            context.coordinator.resetZoom(animated: true)
        }
    }

    final class Coordinator: NSObject, UIScrollViewDelegate {
        weak var scrollView: MapZoomScrollView?
        weak var imageView: UIImageView?
        var maxZoomMultiplier: CGFloat = 6
        var lastResetTrigger = 0
        private var baseZoomScale: CGFloat = 1
        private var lastLayoutBounds: CGSize = .zero
        private var didSetInitialZoom = false

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            imageView
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            centerImage(in: scrollView)
        }

        func layoutImageIfNeeded(in scrollView: UIScrollView) {
            guard let imageView, let image = imageView.image else { return }

            let boundsSize = scrollView.bounds.size
            guard boundsSize.width > 1, boundsSize.height > 1 else { return }

            let boundsChanged = abs(boundsSize.width - lastLayoutBounds.width) > 1
                || abs(boundsSize.height - lastLayoutBounds.height) > 1
            guard boundsChanged || !didSetInitialZoom else {
                centerImage(in: scrollView)
                return
            }

            lastLayoutBounds = boundsSize

            let imageSize = image.size
            guard imageSize.width > 0, imageSize.height > 0 else { return }

            let widthScale = boundsSize.width / imageSize.width
            let heightScale = boundsSize.height / imageSize.height
            baseZoomScale = min(widthScale, heightScale)

            imageView.frame = CGRect(origin: .zero, size: imageSize)
            scrollView.contentSize = imageSize
            scrollView.minimumZoomScale = baseZoomScale
            scrollView.maximumZoomScale = baseZoomScale * maxZoomMultiplier

            if !didSetInitialZoom {
                scrollView.zoomScale = baseZoomScale
                didSetInitialZoom = true
            } else if scrollView.zoomScale < scrollView.minimumZoomScale {
                scrollView.zoomScale = scrollView.minimumZoomScale
            }

            centerImage(in: scrollView)
        }

        func resetZoom(animated: Bool) {
            guard let scrollView else { return }
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: animated)
            centerImage(in: scrollView)
        }

        private func centerImage(in scrollView: UIScrollView) {
            guard let imageView else { return }
            let offsetX = max((scrollView.bounds.width - imageView.frame.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.height - imageView.frame.height) * 0.5, 0)
            scrollView.contentInset = UIEdgeInsets(
                top: offsetY,
                left: offsetX,
                bottom: offsetY,
                right: offsetX
            )
        }
    }
}
