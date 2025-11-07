import Foundation

extension WellnessRowView.Model {
    init(_ dto: WellnessSession) {
        self.title = dto.title
        self.category = dto.category.title
        self.duration = "\(dto.durationMinutes) min"
        self.rating = "\(dto.rating)"
        self.url = dto.imageURL
    }
}
