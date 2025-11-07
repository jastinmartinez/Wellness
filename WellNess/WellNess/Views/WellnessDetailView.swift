import SwiftUI
import Kingfisher

struct WellnessDetailView: View {
    
    let model: Model
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                WellnessPhotoView(
                    url: model.url,
                    placeHolder: {
                        ZStack { ProgressView() }
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                    }
                )
                .frame(height: 240)
                .frame(maxWidth: .infinity)
                .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.title).font(.title).bold()
                    HStack(spacing: 12) {
                        Text(model.category)
                        Label(model.duration, systemImage: "clock")
                        Label(model.rating, systemImage: "star.fill")
                    }
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    
                    Divider().padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Label(model.instructor, systemImage: "person.text.rectangle")
                        Label(model.date, systemImage: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Text("About this session")
                        .font(.headline)
                        .padding(.top, 8)
                    Text(model.description)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                WellnessFavoriteButtonView(
                    isFavorite: model.isFavorite,
                    action: model.onFavorite
                )
            }
        }
    }
}

extension WellnessDetailView {
    struct Model {
        let title: String
        let url: URL?
        let category: String
        let duration: String
        let rating: String
        let date: String
        let description: String
        let instructor: String
        let isFavorite: Bool
        let onFavorite: () -> Void
    }
}
