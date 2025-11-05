import SwiftUI

struct LoadingView: View {
    
    let model: Model
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text(model.name).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension LoadingView {
    struct Model {
        let name: String
    }
}
