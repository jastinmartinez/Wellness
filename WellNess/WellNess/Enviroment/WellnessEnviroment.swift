import Foundation

enum WellnessEnvironment {
    
    static var sessionURL: URL? = getURL(
        from: "wellnesssessions"
    )
}

extension WellnessEnvironment {
    private static func getURL(
        from fileName: String
    ) -> URL? {
        Bundle.main.url(
            forResource: fileName.replacingOccurrences(of: ".json", with: ""),
            withExtension: "json"
        )
    }
}
