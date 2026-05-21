import SwiftUI
import AVFoundation

struct EditProfileView: View {
    @Bindable var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showAvatarSourceDialog = false
    @State private var activePickerSource: AvatarPickerSource?
    @State private var showCameraPermissionAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.024) {
                Button {
                    showAvatarSourceDialog = true
                } label: {
                    VStack(spacing: screenHeight * 0.012) {
                        AvatarView(image: viewModel.avatarImage, size: screenHeight * 0.12)
                        Text("Change Avatar")
                            .font(AppTypography.body(0.0166, weight: .medium))
                            .foregroundStyle(AppColors.brandGold)
                    }
                }
                .buttonStyle(.plain)

                AppTextField(
                    title: "Full Name",
                    placeholder: "Your name",
                    text: $viewModel.userName,
                    textContentType: .name,
                    autocapitalization: .words,
                    accentBorderColor: AppColors.white
                )

                AppTextField(
                    title: "Email",
                    placeholder: "you@example.com",
                    text: $viewModel.email,
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    accentBorderColor: AppColors.white
                )

                AppTextField(
                    title: "Phone",
                    placeholder: "+1 (000) 000-0000",
                    text: $viewModel.phone,
                    keyboardType: .phonePad,
                    textContentType: .telephoneNumber,
                    accentBorderColor: AppColors.white
                )

                PrimaryButton(title: "Save", action: {
                    viewModel.persist()
                    dismiss()
                })
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .appScreenBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(AppColors.white)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Profile")
                    .font(AppTypography.body(0.019, weight: .semibold))
                    .foregroundStyle(AppColors.white)
            }
        }
        .confirmationDialog("Change Avatar", isPresented: $showAvatarSourceDialog, titleVisibility: .visible) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button("Take Photo") {
                    openCamera()
                }
            }
            Button("Choose Photo") {
                activePickerSource = .photoLibrary
            }
            Button("Cancel", role: .cancel) {}
        }
        .fullScreenCover(item: $activePickerSource) { source in
            FullscreenImagePicker(
                source: source,
                onImagePicked: { image in
                    viewModel.avatarImage = image
                    viewModel.persist()
                    let pickedFromLibrary = source == .photoLibrary
                    activePickerSource = nil
                    if pickedFromLibrary {
                        presentCameraAccessAlertIfNeeded()
                    }
                },
                onCancel: {
                    activePickerSource = nil
                }
            )
            .ignoresSafeArea()
        }
        .alert("Camera Access", isPresented: $showCameraPermissionAlert) {
            Button("Settings") {
                CameraPermission.openSettings()
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text("Allow camera access in Settings to take a new profile photo with your camera.")
        }
    }

    private func openCamera() {
        CameraPermission.requestForAvatarPhoto {
            activePickerSource = .camera
        } onDenied: {
            showCameraPermissionAlert = true
        }
    }

    private func presentCameraAccessAlertIfNeeded() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status != .authorized {
            showCameraPermissionAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(viewModel: ProfileViewModel())
    }
    .background(GradientBackgroundView())
}
