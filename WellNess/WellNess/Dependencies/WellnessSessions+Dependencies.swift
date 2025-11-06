import ComposableArchitecture
import Foundation

private enum WellnessSessionsKey: DependencyKey {
    static var liveValue: WellnessSessionDataSource = {
        WellnessSessionDataSource(
            getWellnessSession: {
                do {
                    guard let url = WellnessEnvironment.sessionURL else {
                        throw Error.fileNotFound
                    }
                    do {
                        let data = try Data(contentsOf: url)
                        return try JSONDecoder.wellness.decode(
                            [WellnessSession].self,
                            from: data
                        )
                    } catch {
                        throw Error.decoding
                    }
                }
            }
        )
    }()
}

extension DependencyValues {
    var wellnessSessionDataSource: WellnessSessionDataSource {
        get { self[WellnessSessionsKey.self] }
        set { self[WellnessSessionsKey.self] = newValue }
    }
}

extension WellnessSessionsKey {
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
