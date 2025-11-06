import ComposableArchitecture
import Foundation

struct WWellnessSessionsReducer: Reducer {
    
    struct State: Equatable {
        var showIsLoadingWellnessSessions = false
        var wellnessSessions: IdentifiedArrayOf<WellnessSession> = []
        var wellnessSessionsError: String = ""
        var showWellnessSessionsError: Bool = false
    }
    
    enum Action {
        case didTapLoadWellnessSessions
        case didReceiveWellnessSessions([WellnessSession])
        case didReceiveWellnessSessionsError(Error)
    }
    
    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        switch action {
            case .didTapLoadWellnessSessions:
                state.showIsLoadingWellnessSessions = true
            case let .didReceiveWellnessSessions(wellnessSessions):
                let wellnessSessionsSorted = wellnessSessions.sorted(by: {$0.date < $1.date })
                state.showIsLoadingWellnessSessions = false
                state.wellnessSessions = IdentifiedArray(uniqueElements: wellnessSessionsSorted, id: \.id)
            case let .didReceiveWellnessSessionsError(error):
                state.showIsLoadingWellnessSessions = false
                state.showWellnessSessionsError = true
                state.wellnessSessionsError = error.localizedDescription
        }
        return .none
    }
}
