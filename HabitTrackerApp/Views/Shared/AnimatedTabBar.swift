import SwiftUI

struct AnimatedTabBar: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        HStack {
            ForEach(TabItem.allCases) { tab in
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(selectedTab == tab ? Color.primary : .gray)
                        if selectedTab == tab {
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.primary)
                                .transition(.scale)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(.thinMaterial)
    }
}
