
import Foundation

final class WellnessService: WellnessProvider {

    private let remoteDataSource: WellnessProvider
    private let localDataSource: WellnessProvider
    
    init(
        remoteDataSource: WellnessProvider,
        localDataSource: WellnessProvider
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchSessions() async throws -> [WellnessSession] {
       let remote =  try await  remoteDataSource.fetchSessions()
       let localDataSource = try await  localDataSource.fetchSessions()
        
        return remote.filter { wellnessSession in
            !localDataSource.contains(where: { $0.id == wellnessSession.id })
        } + localDataSource
    }
    
    func setFavoriteSession(_ session: WellnessSession) {
        localDataSource.setFavoriteSession(session)
    }
}

