import SwiftUI
import Kingfisher

struct WellnessPhotoView<P: View>: View {
    
    let url: URL?
    let placeHolder: () -> P
    
    init(
        url: URL?,
        placeHolder: @escaping () -> P
    ) {
        self.url = url
        self.placeHolder = placeHolder
    }
    
    var body: some View {
        KFImage.url(
            url,
            cacheKey: url?.absoluteString
        )
        .placeholder {
            placeHolder()
        }
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .fade(duration: 0.25)
        .serialize(as: .PNG)
        .resizable()
        .scaledToFill()
    }
}
