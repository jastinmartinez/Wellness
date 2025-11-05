import SwiftUI

struct WellnessFavoriteButtonView: View {
    
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .imageScale(.large)
                .symbolEffect(.bounce, value: isFavorite)
        }
        .buttonStyle(.borderedProminent)
        .tint(.pink)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }
}
