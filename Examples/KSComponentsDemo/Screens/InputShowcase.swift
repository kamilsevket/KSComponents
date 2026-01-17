import SwiftUI
import KSComponents

struct InputShowcase: View {
    @State private var basicText = ""
    @State private var emailText = ""
    @State private var usernameText = "john_doe"
    @State private var errorText = "invalid-email"
    @State private var password = ""
    @State private var searchText = ""
    @State private var multilineText = "This is a multi-line text editor that allows users to enter longer form content."

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Text Field", description: "Basic text input with label and icon") {
                    VStack(spacing: KS.Spacing.md) {
                        KSTextField(
                            "Enter your email",
                            text: $emailText,
                            label: "Email",
                            icon: "envelope"
                        )

                        KSTextField(
                            "Enter username",
                            text: $usernameText,
                            label: "Username",
                            icon: "person",
                            helperText: "Choose a unique username"
                        )
                    }
                }

                ShowcaseSection("Validation States", description: "Error and disabled states") {
                    VStack(spacing: KS.Spacing.md) {
                        KSTextField(
                            "Enter email",
                            text: $errorText,
                            label: "Email",
                            icon: "envelope",
                            errorText: "Please enter a valid email address"
                        )

                        KSTextField(
                            "Disabled field",
                            text: .constant(""),
                            label: "Disabled",
                            isDisabled: true
                        )
                    }
                }

                ShowcaseSection("Secure Field", description: "Password input with visibility toggle") {
                    KSSecureField(
                        "Enter password",
                        text: $password,
                        label: "Password"
                    )
                }

                ShowcaseSection("Search Field", description: "Search input with clear button") {
                    KSSearchField(
                        "Search...",
                        text: $searchText
                    )
                }

                ShowcaseSection("Text Editor", description: "Multi-line text input") {
                    KSTextEditor(
                        "Enter your message...",
                        text: $multilineText,
                        label: "Message"
                    )
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Inputs")
    }
}

#Preview {
    NavigationStack {
        InputShowcase()
    }
}
