import Foundation
import ComposableArchitecture
import SwiftUI

extension WellnessListView  {
    init(
        viewStore: ViewStoreOf<WellnessSessionsReducer>,
        store: StoreOf<WellnessSessionReducer>
    ) {
        let isLoading = viewStore.showIsLoadingWellnessSessions
        let wellnessSessions = viewStore.wellnessSessions
        let favoriteCount = wellnessSessions.filter(\.isFavorite).count
        
        self.model = .init(
            isLoading: isLoading,
            favoriteCount: favoriteCount,
            wellnessSessions: wellnessSessions,
            onAppear: {
                viewStore.send(.didTapLoadWellnessSessionsOnce)
            }
        )
        self.wellNessRowView = { wellnessSession in
            AnyView(
                WellnessRowView(
                    model: .init(
                        wellnessSession
                    )
                )
            )
        }
        self.wellNessDetailView = { wellnessSession in
            AnyView(
                WithViewStore(store, observe: { $0 }) { viewStore in
                    WellnessDetailView(
                        model: .init(
                            viewStore: viewStore
                        )
                    )
                    .onAppear {
                        viewStore.send(.didTapSelect(wellnessSession))
                    }
                }
            )
        }
    }
}
