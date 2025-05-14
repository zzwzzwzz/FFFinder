import SwiftUI

// A unified placeholder for media content (films, festivals, posters)
struct MediaPlaceholder: View {
    enum MediaType {
        case film
        case festival
        case poster
        
        var iconName: String {
            switch self {
            case .film, .poster: return "film"
            case .festival: return "film.stack"
            }
        }
    }
    
    let title: String?
    let mediaType: MediaType
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let showInitial: Bool
    
    init(
        title: String? = nil,
        mediaType: MediaType = .film,
        width: CGFloat? = nil,
        height: CGFloat = 75,
        cornerRadius: CGFloat = 8,
        backgroundColor: Color = Color.gray.opacity(0.2),
        showInitial: Bool = true
    ) {
        self.title = title
        self.mediaType = mediaType
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.showInitial = showInitial
    }
    
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .fill(backgroundColor)
                .if(width != nil) { view in
                    view.frame(width: width, height: height)
                }
                .if(width == nil) { view in
                    view.frame(height: height)
                }
                .cornerRadius(cornerRadius)
            
            // Content
            VStack(spacing: 4) {
                // Icon
                Image(systemName: mediaType.iconName)
                    .font(.system(size: min(height/4, 32)))
                    .foregroundColor(.gray)
                
                // Optional initial letter
                if showInitial, let title = title, !title.isEmpty {
                    Text(title.prefix(1))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

extension MediaPlaceholder {
    // Film poster placeholder (small)
    static func filmPoster(title: String) -> MediaPlaceholder {
        MediaPlaceholder(
            mediaType: .film,
            width: 50,
            height: 75,
            cornerRadius: 8
        )
    }
    
    // Film poster placeholder (medium)
    static func filmPosterMedium(title: String) -> MediaPlaceholder {
        MediaPlaceholder(
            mediaType: .film,
            width: 120,
            height: 180,
            cornerRadius: 8
        )
    }
    
    // Film poster placeholder (large)
    static func filmPosterLarge(title: String) -> MediaPlaceholder {
        MediaPlaceholder(
            mediaType: .film,
            width: 160,
            height: 240,
            cornerRadius: 12
        )
    }
    
    // Festival image placeholder
    static func festival(height: CGFloat = 160) -> MediaPlaceholder {
        MediaPlaceholder(
            mediaType: .festival,
            width: nil,
            height: height,
            cornerRadius: 12,
            showInitial: false
        )
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 10) {
            MediaPlaceholder.filmPoster(title: "")
            MediaPlaceholder.filmPosterMedium(title: "")
            MediaPlaceholder.filmPosterLarge(title: "")
        }
        
        MediaPlaceholder.festival()
            .frame(width: 300)
        
        MediaPlaceholder(
            title: "",
            mediaType: .poster,
            width: 100,
            height: 100,
            cornerRadius: 20,
            backgroundColor: Color.black.opacity(0.8),
            showInitial: true
        )
    }
    .padding()
} 
