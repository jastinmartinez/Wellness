import Foundation
internal import Combine

final class WellnessSelectedViewModel: ObservableObject {
    
    @Published var wellnessSession: WellnessSession
//    private let wellnessViewModel: WellnessViewModel
    
    init(
        wellnessSession: WellnessSession,
//        wellnessViewModel: WellnessViewModel
    ) {
        self.wellnessSession = wellnessSession
//        self.wellnessViewModel = wellnessViewModel
    }
    
    var url: URL? {
        wellnessSession.imageURL
    }
    
    var title: String {
        wellnessSession.title
    }
    
    var categoryTitle: String {
        wellnessSession.category.title
    }
    
    var rating: String {
        "\(wellnessSession.rating)"
    }
    
    var durationMinutes: String {
        "\(wellnessSession.durationMinutes) min"
    }
    
    var instructor: String {
        "Instructor: \(wellnessSession.instructor)"
    }
    
    var description: String {
        wellnessSession.description
    }
    
    var date: String {
        "Date: \(DateFormatter.medium.string(from: wellnessSession.date))"
    }
    
    var isFavorite: Bool {
        wellnessSession.isFavorite
    }
    
    func favorite() {
        let oldWellnessSession = wellnessSession
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
//        wellnessViewModel.setFavorite(
//            newWellnessSession
//        )
        wellnessSession = newWellnessSession
    }
}
