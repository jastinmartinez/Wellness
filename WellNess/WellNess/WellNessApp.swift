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
    
    private let wellnessStore: StoreOf<WWellnessSessionsReducer> = {
        Store(initialState: WWellnessSessionsReducer.State()) {
            WWellnessSessionsReducer()
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            WellnessListView(
                wellnessSessionStore: wellnessStore,
                wellNessRowView: { wellnessSession in
                    WellnessRowView(
                        viewModel: .init(
                            wellnessSession: wellnessSession,
//                            wellnessViewModel: wellnessViewModel
                        )
                    )
                },
                wellNessDetailView: { wellnessSession in
                    WellnessDetailView(
                        viewModel: .init(
                            wellnessSession: wellnessSession,
//                            wellnessViewModel: wellnessViewModel
                        )
                    )
                }
            )
        }
    }
}
