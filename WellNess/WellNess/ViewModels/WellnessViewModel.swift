import Foundation
internal import Combine

final class WellnessViewModel: ObservableObject {
    
    @Published var wellnessState: ModelState<[WellnessSession]> = .loading
    
    private let wellnessProvider: WellnessProvider
    
    init(wellnessProvider: WellnessProvider) {
        self.wellnessProvider = wellnessProvider
    }
    
    
    func load() async {
        do {
           let wellnessSession = try await wellnessProvider.fetchSessions()
            await MainActor.run {
                wellnessState = .success(wellnessSession.sorted(by: { $0.date < $1.date }))
            }
        } catch {
            wellnessState = .failure
        }
    }
    
    func setFavorite(_ session: WellnessSession) {
        wellnessProvider.setFavoriteSession(session)
    }
}


extension WellnessViewModel {
    var titleString: String {
        return "Wellness"
    }
    
    var loadingSessionString: String {
        return "loading sessions..."
    }
    
    var favoriteCount: Int {
        if case let .success(sessions) = wellnessState {
            return sessions.filter(\.isFavorite).count
        } else {
            return 0
        }
    }
}
