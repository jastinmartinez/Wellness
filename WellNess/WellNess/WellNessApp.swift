//
//  WellNessApp.swift
//  WellNess
//
//  Created by Jastin on 11/4/25.
//

import SwiftUI

@main
struct WellNessApp: App {
    
    @StateObject var wellnessViewModel: WellnessViewModel
    
    init() {
        let remoteWellnessDataSource = RemoteWellnessService()
        let localViewModel = LocalWellnessService()
        let wellnessService = WellnessService(
            remoteDataSource: remoteWellnessDataSource,
            localDataSource: localViewModel
        )
        self._wellnessViewModel = StateObject(
            wrappedValue: WellnessViewModel(
                wellnessProvider: wellnessService
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            WellnessListView(
                titleString: wellnessViewModel.titleString,
                loadingSessionString: wellnessViewModel.loadingSessionString,
                wellnessState: wellnessViewModel.wellnessState,
                loadWellnessSession: wellnessViewModel.load,
                favoriteCount: wellnessViewModel.favoriteCount,
                wellNessRowView: { wellnessSession in
                    WellnessRowView(
                        viewModel: .init(
                            wellnessSession: wellnessSession,
                            wellnessViewModel: wellnessViewModel
                        )
                    )
                },
                wellNessDetailView: { wellnessSession in
                    WellnessDetailView(
                        viewModel: .init(
                            wellnessSession: wellnessSession,
                            wellnessViewModel: wellnessViewModel
                        )
                    )
                }
            )
        }
    }
}
