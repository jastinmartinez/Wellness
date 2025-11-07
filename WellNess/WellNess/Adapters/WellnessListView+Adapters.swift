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
            },
            onRowTap: { wellnessSession in
                viewStore.send(.didTapSaveWellnessSession(.didTapSelect(wellnessSession)))
                viewStore.send(.didShowWellnessSession(true))
            },
            showNavigation: viewStore.showWellnessSession,
            onNavigation: { isPresented in
                viewStore.send(.didShowWellnessSession(isPresented))
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
        
        self.wellNessDetailView = {
            AnyView(
                WithViewStore(store, observe: { $0 }) { viewStore in
                    WellnessDetailView(
                        model: .init(
                            viewStore: viewStore
                        )
                    )
                }
            )
        }
    }
}
