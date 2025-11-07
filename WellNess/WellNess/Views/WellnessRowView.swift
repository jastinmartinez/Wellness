import SwiftUI
import Kingfisher

struct WellnessRowView: View {
    
    let model: Model
    
    init(
        model: Model
    ) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            KFImage.url(model.url)
                .placeholder {
                    ZStack { ProgressView() }
                        .frame(width: 72, height: 72)
                        .background(.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .serialize(as: .PNG)
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
           
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(model.title)
                        .font(.headline)
                        .lineLimit(1)
                }
                HStack(spacing: 8) {
                    Text(model.category)
                    Text("•")
                    Text(model.duration)
                    Text("•")
                    Text(model.rating)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(model.title), \(model.category), \(model.duration) \(model.rating)")
    }
}

extension WellnessRowView {
    struct Model {
        let title: String
        let category: String
        let rating: String
        let duration: String
        let url: URL?
    }
}
