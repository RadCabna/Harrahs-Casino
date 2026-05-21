import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTab = .events
    @State private var profileViewModel: ProfileViewModel
    @State private var createBookingViewModel: CreateBookingViewModel
    @State private var eventsViewModel: EventsViewModel
    @State private var myBookingsViewModel: MyBookingsViewModel

    init() {
        let profile = ProfileViewModel()
        let bookings = MyBookingsViewModel()
        _profileViewModel = State(initialValue: profile)
        _myBookingsViewModel = State(initialValue: bookings)
        _createBookingViewModel = State(
            initialValue: CreateBookingViewModel(
                bookingsViewModel: bookings,
                profileViewModel: profile
            )
        )
        _eventsViewModel = State(
            initialValue: EventsViewModel(
                bookingsViewModel: bookings,
                profileViewModel: profile
            )
        )
    }

    var body: some View {
        ZStack {
            GradientBackgroundView()
            tabContent
        }
    }

    private var tabContent: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ProfileView(viewModel: profileViewModel)
            }
            .tabItem { Label(MainTab.profile.title, systemImage: MainTab.profile.systemImage) }
            .tag(MainTab.profile)

            NavigationStack {
                CreateBookingView(viewModel: createBookingViewModel)
            }
            .tabItem { Label(MainTab.createBooking.title, systemImage: MainTab.createBooking.systemImage) }
            .tag(MainTab.createBooking)

            NavigationStack {
                EventsListView(viewModel: eventsViewModel)
            }
            .tabItem { Label(MainTab.events.title, systemImage: MainTab.events.systemImage) }
            .tag(MainTab.events)

            NavigationStack {
                MyBookingsView(viewModel: myBookingsViewModel)
            }
            .tabItem { Label(MainTab.myBookings.title, systemImage: MainTab.myBookings.systemImage) }
            .tag(MainTab.myBookings)

            NavigationStack {
                CasinoMapView()
            }
            .tabItem { Label(MainTab.map.title, systemImage: MainTab.map.systemImage) }
            .tag(MainTab.map)
        }
        .tint(AppColors.brandRed)
        .onAppear { configureTabBarAppearance() }
        .overlay {
            if profileViewModel.showLoyaltyUpgrade {
                LoyaltyUpgradeOverlay(tier: profileViewModel.tier) {
                    profileViewModel.showLoyaltyUpgrade = false
                }
                .transition(.opacity)
                .zIndex(10)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: profileViewModel.showLoyaltyUpgrade)
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
