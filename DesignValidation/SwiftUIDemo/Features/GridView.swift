//
//  GridView.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 25/11/21.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    Color.red.frame(height: 300)
                    gridView
                    Spacer()
                }
            }.navigationBarTitle("Profile", displayMode: .inline)

        }
    }

    var gridView: some View {
        let threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        return ScrollView(.horizontal) {
            LazyHGrid(rows: threeColumnGrid, spacing: 10, content: {
                ForEach((0...50), id: \.self) { index in
                    ZStack {
                        Color.blue
                        Text(String(index))
                    }.aspectRatio(1, contentMode: .fit)
                }

            }).padding(10)
        }.aspectRatio(1, contentMode: .fit)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
