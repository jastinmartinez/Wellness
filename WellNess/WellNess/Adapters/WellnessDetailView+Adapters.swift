import Foundation
import ComposableArchitecture

extension WellnessDetailView.Model {
    init(
        viewStore: ViewStoreOf<WellnessSessionReducer>
    ) {
        let dto = viewStore.wellnessSession
        self.title = dto?.title ?? ""
        self.category = dto?.category.title ?? ""
        if let date = dto?.date {
            self.date =  "Date: \(DateFormatter.medium.string(from: date))"
        } else {
            self.date = ""
        }
        self.description = dto?.description ?? ""
        self.duration = "\(dto?.durationMinutes, default: "") min"
        self.isFavorite = dto?.isFavorite ?? false
        self.onFavorite = { viewStore.send(.didTapFavorite) }
        self.rating = "\(dto?.rating, default: "")"
        self.url = dto?.imageURL
        self.instructor =  "Instructor: \(dto?.instructor, default: "")"
    }
}
