import Foundation

final class LocalWellnessService {
    
    private var dic = [String: WellnessSession]()

    func setFavoriteSession(_ session: WellnessSession) {
        if let _ = dic[session.id] {
            dic[session.id] = nil
        } else {
            dic[session.id] = session
        }
    }
    func fetchSessions() async throws -> [WellnessSession] {
        dic.map(\.value)
    }
}
