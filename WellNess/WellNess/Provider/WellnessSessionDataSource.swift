import Foundation

struct WellnessSessionDataSource {
    var getWellnessSession: () async throws -> [WellnessSession]
}
