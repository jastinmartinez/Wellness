import SwiftUI

struct WellnessListView<D: View, R: View>: View {
    
    private let titleString: String
    private let loadingSessionString: String
    private let wellnessState: ModelState<[WellnessSession]>
    private let favoriteCount: Int
    private let loadWellnessSession: () async -> Void
    private let wellNessRowView: (WellnessSession) -> R
    private let wellNessDetailView: (WellnessSession) -> D
    
    init(
        titleString: String,
        loadingSessionString: String,
        wellnessState: ModelState<[WellnessSession]>,
        loadWellnessSession: @escaping () async -> Void,
        favoriteCount: Int,
        wellNessRowView: @escaping (WellnessSession) -> R,
        wellNessDetailView: @escaping (WellnessSession) -> D
    ) {
        self.titleString = titleString
        self.loadingSessionString = loadingSessionString
        self.wellnessState = wellnessState
        self.wellNessDetailView = wellNessDetailView
        self.favoriteCount = favoriteCount
        self.wellNessRowView = wellNessRowView
        self.loadWellnessSession = loadWellnessSession
    }
    
    var body: some View {
        NavigationStack {
            Group {
                content(
                    using: wellnessState
                )
            }
            .navigationTitle(titleString)
            .toolbarTitleDisplayMode(.large)
            .toolbar { favoritesToolbar }
            .task {
                await loadWellnessSession()
            }
        }
    }
    
    @ViewBuilder
    private func content(
        using dataState: ModelState<[WellnessSession]>
    ) -> some View {
        switch dataState {
            case .loading:
                LoadingView(
                    model: .init(
                        name: loadingSessionString
                    )
                )
            case let .success(data):
                List {
                    ForEach(data) { wellnessSession in
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
            case .failure:
                EmptyView()
        }
    }
    
    @ToolbarContentBuilder
    private var favoritesToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 6) {
                Image(systemName: "heart.fill").symbolRenderingMode(.multicolor)
                Text("\(favoriteCount)").font(.headline)
            }
            .accessibilityLabel("Favorites count: \(favoriteCount)")
        }
    }
}
