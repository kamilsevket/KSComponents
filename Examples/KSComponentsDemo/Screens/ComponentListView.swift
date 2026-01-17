import SwiftUI
import KSComponents

struct ComponentListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Foundation") {
                    NavigationLink("Tokens & Theme", destination: ThemeShowcase())
                }

                Section("Components") {
                    NavigationLink("Buttons", destination: ButtonShowcase())
                    NavigationLink("Inputs", destination: InputShowcase())
                    NavigationLink("Cards", destination: CardShowcase())
                    NavigationLink("Lists", destination: ListShowcase())
                    NavigationLink("Navigation", destination: NavigationShowcase())
                    NavigationLink("Modals", destination: ModalShowcase())
                    NavigationLink("Loading", destination: LoadingShowcase())
                    NavigationLink("Badges & Tags", destination: BadgeShowcase())
                    NavigationLink("Avatars", destination: AvatarShowcase())
                    NavigationLink("Forms", destination: FormShowcase())
                    NavigationLink("States", destination: StateShowcase())
                }

                Section("Motion") {
                    NavigationLink("Animations", destination: AnimationShowcase())
                }
            }
            .navigationTitle("KSComponents")
        }
    }
}

#Preview {
    ComponentListView()
}
