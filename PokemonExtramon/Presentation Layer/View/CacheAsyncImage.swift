//
//  CacheAsyncImage.swift
//  PokemonExtramon
//
//  Created by Lion on 18/03/2024.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
        
        private let url: URL
        private let scale: CGFloat
        private let transaction: Transaction
        private let content: (AsyncImagePhase) -> Content
        
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
       @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
    
        if let cached = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")
            content(.success(cached))
        } else {
            let _ = print("request \(url.absoluteString)")
            AsyncImage(url: url,
                       scale: scale,
                       transaction: transaction) {
                phase in
                cacheAndRender(phase: phase)
            }
        }
   
    }
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return  content(phase)

    }
}


struct CacheAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
    
        let sampleImageURL = URL(string: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png")!

        CacheAsyncImage(url: sampleImageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 100, height: 100)
            case .failure(_):
                Image("pokeball")


            @unknown default:
                Image("pokeball")
            }
        }
    }
}

fileprivate class ImageCache {
    
    static private var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
