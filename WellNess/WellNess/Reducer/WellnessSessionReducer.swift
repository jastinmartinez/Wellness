import ComposableArchitecture
import Foundation

struct WellnessSessionReducer: Reducer {
    
    struct State: Equatable {
        var wellnessSession: WellnessSession? = nil
    }
    
    enum Action: Equatable {
        case didTapSelect(WellnessSession)
        case didTapFavorite
        case delegate(Delegate)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .didTapFavorite:
                    guard let oldWellnessSession = state.wellnessSession else {
                        return .none
                    }
                    let newWellnessSession = WellnessSession(
                        id: oldWellnessSession.id,
                        title: oldWellnessSession.title,
                        category: oldWellnessSession.category,
                        durationMinutes: oldWellnessSession.durationMinutes,
                        rating: oldWellnessSession.rating,
                        description: oldWellnessSession.description,
                        instructor: oldWellnessSession.instructor,
                        date: oldWellnessSession.date,
                        isFavorite: !oldWellnessSession.isFavorite
                    )
                    state.wellnessSession = newWellnessSession
                    return .send(.delegate(.saveWellnessSession(newWellnessSession)))
                case .delegate:
                    return .none
                case let .didTapSelect(wellnessSession):
                    state.wellnessSession = wellnessSession
                    return .none
            }
        }
    }
}


extension WellnessSessionReducer.Action {
    enum Delegate: Equatable {
        case saveWellnessSession(WellnessSession)
    }
}
