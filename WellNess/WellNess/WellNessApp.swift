//
//  WellNessApp.swift
//  WellNess
//
//  Created by Jastin on 11/4/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct WellNessApp: App {
    
    private let wellnessStore: StoreOf<WellnessSessionsReducer> = {
        Store(initialState: WellnessSessionsReducer.State()) {
            WellnessSessionsReducer()
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            WithViewStore(wellnessStore, observe: { $0 }) { viewStore in
                WellnessListView(
                    viewStore: viewStore,
                    store: wellnessStore.scope(state: \.wellnessSession, action: \.didTapSaveWellnessSession)
                )
            }
        }
    }
}
