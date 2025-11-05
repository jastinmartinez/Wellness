import SwiftUI

struct WellnessRowView: View {
    
    let viewModel: WellnessSelectedViewModel
    
    init(
        viewModel: WellnessSelectedViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: viewModel.url) { phase in
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
                    Text(viewModel.title)
                        .font(.headline)
                        .lineLimit(1)
                }
                HStack(spacing: 8) {
                    Text(viewModel.categoryTitle)
                    Text("•")
                    Text(viewModel.durationMinutes)
                    Text("•")
                    Text(viewModel.rating)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(viewModel.title), \(viewModel.categoryTitle), \(viewModel.durationMinutes) \(viewModel.rating)")
    }
}
