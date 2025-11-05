import Foundation


final class RemoteWellnessService: WellnessProvider {
    
    func fetchSessions() async throws -> [WellnessSession] {
        do {
            guard let url = WellnessEnvironment.sessionURL else {
                throw Error.fileNotFound
            }
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder.wellness.decode([WellnessSession].self, from: data)
            } catch {
                throw Error.decoding
            }
        }
    }
    
    func setFavoriteSession(_ session: WellnessSession) {
        /* no op remote operation */
    }
}

//MARK: Error
extension RemoteWellnessService {
    enum Error: LocalizedError {
        case fileNotFound, decoding, invalidURL
        var errorDescription: String? {
            switch self {
                case .fileNotFound: return "We could not locate the wellness sessions file"
                case .decoding: return "We couldn't read the server response."
                case .invalidURL: return "we can't reach out to the data source."
            }
        }
    }
}
