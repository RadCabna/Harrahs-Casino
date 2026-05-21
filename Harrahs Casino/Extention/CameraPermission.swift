import AVFoundation
import UIKit

enum CameraPermission {
    static func requestForAvatarPhoto(
        onAuthorized: @escaping () -> Void,
        onDenied: @escaping () -> Void
    ) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            onAuthorized()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        onAuthorized()
                    } else {
                        onDenied()
                    }
                }
            }
        case .denied, .restricted:
            onDenied()
        @unknown default:
            onDenied()
        }
    }

    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
