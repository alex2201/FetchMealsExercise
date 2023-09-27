//
//  LazyImage.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import SwiftUI

struct LazyImage<Cache: ImageCache, Content: View, Placeholder: View>: View where Cache.Key == NSURL {
    @State private var image: UIImage? = nil
    
    let imageView: (UIImage) -> Content
    let placeHolder: () -> Placeholder
    
    let url: URL
    let cache: Cache
    
    init(url: URL, cache: Cache = DefaultImageCache.shared, @ViewBuilder imageView: @escaping (UIImage) -> Content, @ViewBuilder placeHolder: @escaping () -> Placeholder) {
        self.url = url
        self.placeHolder = placeHolder
        self.cache = cache
        self.imageView = imageView
    }
    
    var body: some View {
        if let image {
            imageView(image)
        } else {
            placeHolder()
                .task {
                    image = await cache.getImage(usingKey: url.asNSURL)
                }
        }
    }
}

#Preview {
    LazyImage(url: URL(string: "https://www.themealdb.com/images/media/meals/vvusxs1483907034.jpg")!) { image in
        Image(uiImage: image)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    } placeHolder: {
        Image(systemName: "x.circle")
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    }
}
