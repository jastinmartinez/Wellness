import SwiftUI

struct WellnessListView: View {
    
    let model: Model
    let wellNessRowView: (WellnessSession) -> AnyView
    let wellNessDetailView: (WellnessSession) -> AnyView
    
    init(
        model: Model,
        wellNessRowView: @escaping (WellnessSession) -> AnyView,
        wellNessDetailView: @escaping (WellnessSession) -> AnyView
    ) {
        self.model = model
        self.wellNessDetailView = wellNessDetailView
        self.wellNessRowView = wellNessRowView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.isLoading {
                    LoadingView(
                        model: .init(
                            name: "loading sessions..."
                        )
                    )
                } else {
                    List {
                        ForEach(model.wellnessSessions) { wellnessSession in
                            NavigationLink(value: wellnessSession) {
                                wellNessRowView(wellnessSession)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationDestination(for: WellnessSession.self) { wellnessSession in
                        wellNessDetailView(
                            wellnessSession
                        )
                    }
                }
            }
            .navigationTitle("Wellness")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 6) {
                        Image(systemName: "heart.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("\(model.favoriteCount)").font(.headline)
                    }
                    .accessibilityLabel("Favorites count: \(model.favoriteCount)")
                }
            }
            .onAppear {
                model.onAppear()
            }
        }
    }
}


extension WellnessListView {
    struct Model {
        let isLoading: Bool
        let favoriteCount: Int
        let wellnessSessions: [WellnessSession]
        let onAppear: () -> Void
    }
}
