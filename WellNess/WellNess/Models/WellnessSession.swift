import Foundation

struct WellnessSession: Identifiable, Codable, Equatable, Hashable {
    
    let id: String
    let title: String
    let category: Category
    let durationMinutes: Int
    let rating: Double
    let imageURL: URL?
    let description: String
    let instructor: String
    let date: Date
    let isFavorite: Bool
    
    enum Category: String, Codable, CaseIterable, Identifiable {
        case yoga, meditation, massage, breathwork, pilates
        var id: String { rawValue }
        
        var title: String {
            switch self {
                case .yoga: return "Yoga"
                case .meditation: return "Meditation"
                case .massage: return "Massage"
                case .breathwork: return "Breathwork"
                case .pilates: return "Pilates"
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, category, durationMinutes, rating, imageURL, description, instructor, date, isFavorite
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(WellnessSession.Category.self, forKey: .category)
        self.durationMinutes = try container.decode(Int.self, forKey: .durationMinutes)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        self.description = try container.decode(String.self, forKey: .description)
        self.instructor = try container.decode(String.self, forKey: .instructor)
        self.date = try container.decode(Date.self, forKey: .date)
        self.isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
    
    init(
        id: String,
        title: String,
        category: WellnessSession.Category,
        durationMinutes: Int,
        rating: Double,
        imageURL: URL? = nil,
        description: String,
        instructor: String,
        date: Date,
        isFavorite: Bool
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.durationMinutes = durationMinutes
        self.rating = rating
        self.imageURL = imageURL
        self.description = description
        self.instructor = instructor
        self.date = date
        self.isFavorite = isFavorite
    }
}
