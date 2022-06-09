//
//  ContentView.swift
//  FitnessApp
//
//  Created by Gaurang on 11/05/22.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State var showDetailView = false
    private let images: [String] = Array(1...6).map({"user-\($0)"})
    @State var currentImage: String = "user-1"
    var body: some View {
        ZStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 10) {
                ForEach(images, id: \.self) { image in
                    GeometryReader { geo in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                            
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .matchedGeometryEffect(id: image, in: animation, anchor: .center)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showDetailView = true
                            currentImage = image
                        }
                    }
                }
            }.padding(10)
            if showDetailView {
                DetailsView(imageName: currentImage,
                            showDetailView: $showDetailView,
                            animation: animation)
            }
        }
        
    }
}

struct DetailsView: View {
    let imageName: String
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    var body: some View {
        ZStack {
            
            Image(imageName).resizable().scaledToFit()
                .matchedGeometryEffect(id: imageName, in: animation, anchor: .center)
            
            ZStack(alignment: .top) {
                Button(action: {
                    withAnimation {
                        showDetailView = false
                    }
                }, label: {
                    Image(app: .exit).padding(30)
                }).foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
