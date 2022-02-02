//
//  SwiftUIView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 15/01/22.
//

import SwiftUI

struct SwiftUIView: View {
    private let threeColumnGrid = [
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid, spacing: 0) {
                ForEach((0...20), id: \.self) { index in
                    Color.red.aspectRatio(1, contentMode: .fill)
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
