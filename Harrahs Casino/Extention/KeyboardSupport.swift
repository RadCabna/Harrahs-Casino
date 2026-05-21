import SwiftUI
import UIKit

enum Keyboard {
    static func dismiss() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

@Observable
final class KeyboardMetrics {
    static let shared = KeyboardMetrics()

    var bottomInset: CGFloat = 0
    private var observers: [NSObjectProtocol] = []

    init() {
        observers.append(
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillChangeFrameNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.update(from: notification)
            }
        )
    }

    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
    }

    private func update(from notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let screenHeight = UIScreen.main.bounds.height
        var height = max(0, screenHeight - frame.origin.y)
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap(\.windows)
            .first(where: \.isKeyWindow) {
            height = max(0, height - window.safeAreaInsets.bottom)
        }
        withAnimation(.easeOut(duration: 0.25)) {
            bottomInset = height
        }
    }
}

private struct KeyboardMetricsKey: EnvironmentKey {
    static let defaultValue: KeyboardMetrics = .shared
}

extension EnvironmentValues {
    var keyboardMetrics: KeyboardMetrics {
        get { self[KeyboardMetricsKey.self] }
        set { self[KeyboardMetricsKey.self] = newValue }
    }
}

private struct ScrollViewKeyboardInsetModifier: ViewModifier {
    @Environment(\.keyboardMetrics) private var keyboardMetrics
    let extraBottom: CGFloat

    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: insetHeight)
        }
    }

    private var insetHeight: CGFloat {
        if keyboardMetrics.bottomInset > 0 {
            return keyboardMetrics.bottomInset + extraBottom
        }
        return extraBottom
    }
}

private struct KeyboardDismissInstaller: UIViewRepresentable {
    func makeUIView(context: Context) -> KeyboardDismissHostView {
        KeyboardDismissHostView()
    }

    func updateUIView(_ uiView: KeyboardDismissHostView, context: Context) {}
}

private final class KeyboardDismissHostView: UIView, UIGestureRecognizerDelegate {
    private weak var installedWindow: UIWindow?
    private var tapGesture: UITapGestureRecognizer?

    override func didMoveToWindow() {
        super.didMoveToWindow()
        installGestureIfNeeded()
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            removeGesture()
        }
        super.willMove(toWindow: newWindow)
    }

    @objc private func handleTap() {
        Keyboard.dismiss()
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return true }
        return !view.isTextInputOrControl
    }

    private func installGestureIfNeeded() {
        guard let window, installedWindow !== window else { return }
        removeGesture()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        window.addGestureRecognizer(tap)
        tapGesture = tap
        installedWindow = window
    }

    private func removeGesture() {
        if let tapGesture, let installedWindow {
            installedWindow.removeGestureRecognizer(tapGesture)
        }
        tapGesture = nil
        installedWindow = nil
    }
}

private extension UIView {
    var isTextInputOrControl: Bool {
        var current: UIView? = self
        while let view = current {
            if view is UITextField || view is UITextView {
                return true
            }
            if let control = view as? UIControl, control.isEnabled {
                return true
            }
            current = view.superview
        }
        return false
    }
}

extension View {
    func dismissKeyboardOnTapOutside() -> some View {
        overlay {
            KeyboardDismissInstaller()
                .frame(width: 0, height: 0)
                .allowsHitTesting(false)
        }
    }

    func appScrollViewSupport(extraBottom: CGFloat = ScreenLayout.scaled(0.008)) -> some View {
        scrollDismissesKeyboard(.interactively)
            .modifier(ScrollViewKeyboardInsetModifier(extraBottom: extraBottom))
    }
}
