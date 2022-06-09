//
//  TeammateDetailsView.swift
//  FitnessApp
//
//  Created by Gaurang on 18/05/22.
//

import SwiftUI

struct TeammateDetailsView: View {
    var animation: Namespace.ID
    @Binding var isShowing: Bool
    let info: TeammateModel
    
    @State var showNameStack: Bool = false
    @State var showDesc: Bool = false
    var body: some View {
        
        VStack(spacing: 0) {
            if showNameStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isShowing.toggle()
                        }
                    }, label: {
                        Image(app: .leftArrow)
                    })
                    Text("Teammate")
                    Spacer()
                }.padding(.horizontal)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    GeometryReader { geo in
                        Image("user-\(info.id)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(20)
                    .matchedGeometryEffect(id: info.id, in: animation, anchor: .center)
                    if showNameStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(info.name)
                            Text(info.occupation).font(.caption).foregroundColor(.gray)
                            HStack(spacing: 2) {
                                ForEach(0..<3) { _ in
                                    Image(app: .award).renderingMode(.template).foregroundColor(.orange)
                                }
                            }
                        }
                    }
                    if showDesc {
                        VStack(alignment: .leading) {
                            Text("Description")
                            Text(info.about).font(.caption)
                        }
                    }
                    Spacer()
                }.padding()
            }
        }.onAppear {
            withAnimation(.spring(response: 0.5).delay(0.3)) {
                showNameStack = true
            }
            withAnimation(.easeInOut.delay(0.5)) {
                showDesc = true
            }
        }
    }
}

