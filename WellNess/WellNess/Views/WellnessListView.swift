import SwiftUI

struct WellnessListView: View {
    
    let model: Model
    let wellNessRowView: (WellnessSession) -> AnyView
    let wellNessDetailView: () -> AnyView
    
    init(
        model: Model,
        wellNessRowView: @escaping (WellnessSession) -> AnyView,
        wellNessDetailView: @escaping () -> AnyView
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
                        ForEach(model.wellnessSessions, id:\.id) { wellnessSession in
                            Button {
                                model.onRowTap(wellnessSession)
                            } label: {
                                wellNessRowView(wellnessSession)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationDestination(
                        isPresented: Binding(
                            get: { model.showNavigation },
                            set: { value in  model.onNavigation(value) }
                        )
                    ) {
                        wellNessDetailView()
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
        let onRowTap: (WellnessSession) -> Void
        let showNavigation: Bool
        let onNavigation: (Bool) -> Void
    }
}
