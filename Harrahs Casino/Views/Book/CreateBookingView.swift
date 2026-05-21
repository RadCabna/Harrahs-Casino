import SwiftUI

struct CreateBookingView: View {
    @Bindable var viewModel: CreateBookingViewModel

    var body: some View {
        ZStack {
            if viewModel.showTicketSuccess {
                TicketSuccessView(
                    confirmationCode: viewModel.generatedConfirmationCode,
                    title: "\(viewModel.gameType.title) · \(viewModel.generatedBookingNumber)",
                    onDone: { viewModel.reset() }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                bookingForm
            }
        }
        .animation(.spring(response: 0.55, dampingFraction: 0.82), value: viewModel.showTicketSuccess)
        .appScreenBackground()
        .toolbar(.hidden, for: .navigationBar)
    }

    private var bookingForm: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: screenHeight * 0.022) {
                AppMenuHeaderLogo()

                Text("Reserve a Gaming Table")
                    .font(AppTypography.display(0.03))
                    .foregroundStyle(AppColors.textPrimary)

                GameTypeSelector(selection: $viewModel.gameType)

                ChipSelector(
                    title: "Bet Limits",
                    options: BetLimit.allCases.map(\.title),
                    selection: Binding(
                        get: { viewModel.betLimit.title },
                        set: { title in
                            if let limit = BetLimit.allCases.first(where: { $0.title == title }) {
                                viewModel.betLimit = limit
                            }
                        }
                    ),
                    equalWidth: true
                )

                SegmentedOptionPicker(
                    title: "Time",
                    options: BookingTimeSlot.allCases,
                    selection: $viewModel.timeSlot,
                    label: \.shortTitle
                )

                if viewModel.timeSlot == .tomorrow {
                    DatePicker(
                        "Select Time",
                        selection: $viewModel.tomorrowTime,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .font(AppTypography.body(0.019))
                    .foregroundStyle(AppColors.textPrimary)
                    .tint(AppColors.brandRed)
                }

                ChipSelector(
                    title: "Seats",
                    options: PlayerCountOption.allCases.map(\.title),
                    selection: Binding(
                        get: { viewModel.playerCount.title },
                        set: { title in
                            if let option = PlayerCountOption.allCases.first(where: { $0.title == title }) {
                                viewModel.playerCount = option
                            }
                        }
                    ),
                    equalWidth: true
                )

                notesField

                PrimaryButton(
                    title: "Create Booking",
                    action: { viewModel.createBooking() },
                    isEnabled: viewModel.canCreateBooking
                )
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
    }

    private var notesField: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.008) {
            HStack {
                Text("Special Requests")
                    .font(AppTypography.body(0.0166, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
                Spacer()
                Text(viewModel.notesCountText)
                    .font(AppTypography.balance(0.0142))
                    .foregroundStyle(
                        viewModel.specialNotes.count > viewModel.maxNotesLength
                        ? AppColors.destructive
                        : AppColors.textSecondary
                    )
            }
            ZStack(alignment: .topLeading) {
                if viewModel.specialNotes.isEmpty {
                    Text("Prefer a window table")
                        .font(AppTypography.body(0.019))
                        .foregroundStyle(AppColors.placeholder)
                        .padding(.horizontal, screenHeight * 0.04)
                        .padding(.vertical, screenHeight * 0.014)
                }
                TextEditor(text: $viewModel.specialNotes)
                    .font(AppTypography.body(0.019))
                    .foregroundStyle(AppColors.textPrimary)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, screenHeight * 0.03)
                    .padding(.vertical, screenHeight * 0.008)
                    .onChange(of: viewModel.specialNotes) { _, newValue in
                        if newValue.count > viewModel.maxNotesLength {
                            viewModel.specialNotes = String(newValue.prefix(viewModel.maxNotesLength))
                        }
                    }
            }
            .frame(height: screenHeight * 0.12)
            .background(AppColors.fieldBackground)
            .overlay(
                RoundedRectangle(cornerRadius: screenHeight * 0.012)
                    .stroke(AppColors.fieldBorder, lineWidth: screenHeight * 0.0012)
            )
            .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.012))
        }
    }
}

#Preview {
    NavigationStack {
        CreateBookingView(
            viewModel: CreateBookingViewModel(
                bookingsViewModel: MyBookingsViewModel(),
                profileViewModel: ProfileViewModel()
            )
        )
    }
    .background(GradientBackgroundView())
}
