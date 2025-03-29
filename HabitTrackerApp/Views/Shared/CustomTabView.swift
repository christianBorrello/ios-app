import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: TabItem = .home
    @GestureState private var translation: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(TabItem.home)

                TasksView()
                    .tag(TabItem.tasks)

                HabitsView()
                    .tag(TabItem.habits)

                ProgressView()
                    .tag(TabItem.progress)

                SettingsView()
                    .tag(TabItem.settings)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        let currentIndex = selectedTab.rawValue

                        if value.translation.width < -threshold,
                           let next = TabItem(rawValue: currentIndex + 1) {
                            selectedTab = next
                        } else if value.translation.width > threshold,
                                  let previous = TabItem(rawValue: currentIndex - 1) {
                            selectedTab = previous
                        }
                    }
            )

            Divider()
            AnimatedTabBar(selectedTab: $selectedTab)
        }
    }
}


#Preview {
    CustomTabView()
}
