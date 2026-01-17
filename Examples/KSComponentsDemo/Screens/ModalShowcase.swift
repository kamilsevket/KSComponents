import SwiftUI
import KSComponents

struct ModalShowcase: View {
    @State private var showAlert = false
    @State private var showSuccessAlert = false
    @State private var showDestructiveAlert = false
    @State private var showConfirmation = false
    @State private var showToast = false
    @State private var toastMessage = ""

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Custom Alerts", description: "Styled alert dialogs with icons") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Show Info Alert", style: .primary) {
                            showAlert = true
                        }

                        KSButton("Show Success Alert", style: .success) {
                            showSuccessAlert = true
                        }

                        KSButton("Show Destructive Alert", style: .destructive) {
                            showDestructiveAlert = true
                        }
                    }
                }

                ShowcaseSection("Confirmation Dialog", description: "Two-button confirmation") {
                    KSButton("Show Confirmation", style: .secondary) {
                        showConfirmation = true
                    }
                }

                ShowcaseSection("Toast Messages", description: "Temporary notification popups") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Show Success Toast", style: .success) {
                            toastMessage = "Changes saved successfully!"
                            showToast = true
                        }

                        KSButton("Show Error Toast", style: .destructive) {
                            toastMessage = "Something went wrong"
                            showToast = true
                        }
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Modals")
        .overlay {
            if showAlert {
                KSAlert(
                    isPresented: $showAlert,
                    icon: "info.circle.fill",
                    iconColor: KS.Colors.info,
                    title: "Information",
                    message: "This is an informational alert dialog.",
                    primaryButton: .init(title: "OK", action: { })
                )
            }

            if showSuccessAlert {
                KSAlert(
                    isPresented: $showSuccessAlert,
                    icon: "checkmark.circle.fill",
                    iconColor: KS.Colors.success,
                    title: "Success!",
                    message: "Your changes have been saved successfully.",
                    primaryButton: .init(title: "OK", style: .success, action: { })
                )
            }

            if showDestructiveAlert {
                KSAlert(
                    isPresented: $showDestructiveAlert,
                    icon: "exclamationmark.triangle.fill",
                    iconColor: KS.Colors.warning,
                    title: "Delete Item?",
                    message: "This action cannot be undone. Are you sure you want to continue?",
                    primaryButton: .init(title: "Delete", style: .destructive, action: { }),
                    secondaryButton: .init(title: "Cancel", style: .ghost, action: { })
                )
            }

            if showConfirmation {
                KSConfirmationDialog(
                    isPresented: $showConfirmation,
                    title: "Confirm Action",
                    message: "Are you sure you want to proceed with this action?",
                    actions: [
                        .init(title: "Confirm", action: { }),
                        .init(title: "Delete", isDestructive: true, action: { })
                    ],
                    cancelTitle: "Cancel"
                )
            }
        }
        .overlay(alignment: .top) {
            if showToast {
                KSToast(message: toastMessage, type: toastMessage.contains("success") ? .success : .error)
                    .padding(.top, KS.Spacing.xl)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }
            }
        }
        .animation(.spring(), value: showToast)
    }
}

#Preview {
    NavigationStack {
        ModalShowcase()
    }
}
