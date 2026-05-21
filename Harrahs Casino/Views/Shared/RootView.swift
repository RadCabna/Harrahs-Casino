import SwiftUI

struct RootView: View {
    @State private var isAuthenticated = AuthSession.isSignedIn
    @State private var authViewModel = AuthenticationViewModel()

    var body: some View {
        Group {
            if isAuthenticated {
                MainTabView()
                    .transition(.opacity)
            } else {
                AuthenticationView(viewModel: authViewModel) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        isAuthenticated = AuthSession.isSignedIn
                    }
                }
                .transition(.opacity)
            }
        }
        .environment(\.keyboardMetrics, KeyboardMetrics.shared)
        .dismissKeyboardOnTapOutside()
        .animation(.easeInOut(duration: 0.4), value: isAuthenticated)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
