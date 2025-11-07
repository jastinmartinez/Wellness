import SwiftUI

struct WellnessRowView: View {
    
    let model: Model
    
    init(
        model: Model
    ) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: model.url) { phase in
                switch phase {
                    case .empty:
                        ZStack { ProgressView() }
                            .frame(width: 72, height: 72)
                            .background(.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        ZStack { Image(systemName: "photo") }
                            .frame(width: 72, height: 72)
                            .background(.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    @unknown default:
                        EmptyView()
                }
            }
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
