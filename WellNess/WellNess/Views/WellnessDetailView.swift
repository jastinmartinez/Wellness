import SwiftUI

struct WellnessDetailView: View {
    
    @StateObject var viewModel: WellnessSelectedViewModel
    
    init(
        viewModel: WellnessSelectedViewModel
    ) {
        self._viewModel =  StateObject(
            wrappedValue: viewModel
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.url) { phase in
                    switch phase {
                        case .empty:
                            ZStack { ProgressView() }
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .background(.gray.opacity(0.15))
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 240)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .background(.gray.opacity(0.15))
                        @unknown default:
                            EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.title).font(.title).bold()
                    HStack(spacing: 12) {
                        Text(viewModel.categoryTitle)
                        Label(viewModel.durationMinutes, systemImage: "clock")
                        Label(viewModel.rating, systemImage: "star.fill")
                    }
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    
                    Divider().padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Label(viewModel.instructor, systemImage: "person.text.rectangle")
                        Label(viewModel.date, systemImage: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Text("About this session")
                        .font(.headline)
                        .padding(.top, 8)
                    Text(viewModel.description)
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
                    isFavorite: viewModel.isFavorite,
                    action: viewModel.favorite,
                )
            }
        }
    }
}
