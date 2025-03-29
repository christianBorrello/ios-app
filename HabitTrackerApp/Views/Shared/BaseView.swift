import SwiftUI

struct BaseView<Content: View>: View {
    let title: String
    let toolbar: AnyView?
    let content: Content

    init(
        title: String,
        toolbar: AnyView? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.toolbar = toolbar
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    
                    content
                }
                .padding()
            }
            .toolbar {
                if let toolbar = toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        toolbar
                    }
                }
            }
        }
    }
}
