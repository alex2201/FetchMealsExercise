//
//  MealListItemView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import SwiftUI

struct MealListItemView: View {
    let meal: MealCompactItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LazyImage(url: meal.thumbnailUrl!) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
            } placeHolder: {
                Image(systemName: "x.circle")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
            }
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Text(meal.name)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.size.width / 4)
                        .background(Color.black.opacity(0.6))
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
