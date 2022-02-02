//
//  StarView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 13/01/22.
//

import SwiftUI

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 4) {
            ForEach(0..<maxRating) { _ in
                Image(.star)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
            .foregroundColor(.gray.opacity(0.5))
    }
}
