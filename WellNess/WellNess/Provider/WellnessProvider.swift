import Foundation

protocol WellnessProvider {
    func fetchSessions() async throws -> [WellnessSession]
    func setFavoriteSession(_ session: WellnessSession)
}
