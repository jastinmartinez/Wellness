import ComposableArchitecture
import Foundation

struct WellnessSessionsReducer: Reducer {
    
    struct State: Equatable {
        var showIsLoadingWellnessSessions = false
        var wellnessSessions: [WellnessSession] = []
        var wellnessSessionsError: String = ""
        var showWellnessSessionsError: Bool = false
        var wellnessSession = WellnessSessionReducer.State()
    }
    
    @CasePathable
    enum Action {
        case didTapLoadWellnessSessions
        case didReceiveWellnessSessions([WellnessSession])
        case didReceiveWellnessSessionsError(Error)
        case didTapSaveWellnessSession(WellnessSessionReducer.Action)
    }
    
    @Dependency(\.wellnessSessionDataSource) var wellnessSessionDataSource
    
    var body: some Reducer<State, Action> {
        Scope(state: \.wellnessSession, action: \.didTapSaveWellnessSession) {
            WellnessSessionReducer()
        }
        
        Reduce { state, action in
            switch action {
                case .didTapLoadWellnessSessions:
                    state.showIsLoadingWellnessSessions = true
                    return .run(priority: .userInitiated) { [wellnessSessionDataSource] send in
                        do {
                            let wellnessSessions = try await wellnessSessionDataSource.getWellnessSession()
                            await send(.didReceiveWellnessSessions(wellnessSessions))
                        } catch {
                            await send(.didReceiveWellnessSessionsError(error))
                        }
                    }
                case let .didReceiveWellnessSessions(wellnessSessions):
                    let wellnessSessionsSorted = wellnessSessions.sorted(by: {$0.date < $1.date })
                    state.showIsLoadingWellnessSessions = false
                    state.wellnessSessions = wellnessSessionsSorted
                    return .none
                case let .didReceiveWellnessSessionsError(error):
                    state.showIsLoadingWellnessSessions = false
                    state.showWellnessSessionsError = true
                    state.wellnessSessionsError = error.localizedDescription
                    return .none
                case .didTapSaveWellnessSession(.delegate(.saveWellnessSession(let wellnessSession))):
                    if let index = state.wellnessSessions.firstIndex(where: { $0.id == wellnessSession.id }) {
                        state.wellnessSessions[index] = wellnessSession
                    }
                    return .none
                case .didTapSaveWellnessSession:
                    return .none
            }
        }
    }
}
