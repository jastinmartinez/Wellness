import SwiftUI
import ComposableArchitecture

struct WellnessListView<D: View, R: View>: View {
    
    private let wellnessSessionStore: StoreOf<WWellnessSessionsReducer>
    private let wellNessRowView: (WellnessSession) -> R
    private let wellNessDetailView: (WellnessSession) -> D
    
    init(
        wellnessSessionStore: StoreOf<WWellnessSessionsReducer>,
        wellNessRowView: @escaping (WellnessSession) -> R,
        wellNessDetailView: @escaping (WellnessSession) -> D
    ) {
        self.wellnessSessionStore = wellnessSessionStore
        self.wellNessDetailView = wellNessDetailView
        self.wellNessRowView = wellNessRowView
    }
    
    var body: some View {
        WithViewStore(wellnessSessionStore, observe: { $0 } ) { viewStore in
            let titleString = "Wellness"
            let loadingSessionString = "loading sessions..."
            let wellnessSessions = viewStore.wellnessSessions
            let favoriteCount = viewStore.wellnessSessions.lazy.filter(\.isFavorite).count
            let showIsLoadingWellnessSessions = viewStore.showIsLoadingWellnessSessions
            
            NavigationStack {
                VStack {
                    if showIsLoadingWellnessSessions {
                        LoadingView(
                            model: .init(
                                name: loadingSessionString
                            )
                        )
                    } else {
                        List {
                            ForEach(wellnessSessions) { wellnessSession in
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
                .navigationTitle(titleString)
                .toolbarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 6) {
                            Image(systemName: "heart.fill").symbolRenderingMode(.multicolor)
                            Text("\(favoriteCount)").font(.headline)
                        }
                        .accessibilityLabel("Favorites count: \(favoriteCount)")
                    }
                }
                .onAppear {
                    viewStore.send(.didTapLoadWellnessSessions)
                }
            }
        }
    }
}
