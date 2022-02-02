//
//  Tab1.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 29/10/21.
//

import SwiftUI

struct Tab1: View {
    @EnvironmentObject private var viewModel: ViewModel
    let isBird: Bool
    @State var index: Int = 0
    var body: some View {
        NavigationView {
            ScrollView {
                if isBird {
                    CardViewList(animals: $viewModel.birds)
                } else {
                    CardViewList(animals: $viewModel.mammals)
                }

            }
            .background(Color(Colors.darkColor).ignoresSafeArea())
            .navigationBarItems(trailing: Button("Add", action: {
                index += 1
                withAnimation(.spring()) {
                    if isBird {
                        viewModel.birds.append("Bird :\(index)")
                    } else {
                        viewModel.birds.append("Mammal :\(index)")
                    }
                }
            }))
            .navigationBarTitle("Tab 1", displayMode: .inline)
        }
    }

    struct CardViewList: View {
        @Binding var animals: [String]
        var body: some View {
            VStack {
                ForEach(animals, id: \.self) { bird in
                    CardView(bird: bird)
                }
            }.padding(.top)
        }
    }

}

struct CardView: View {
    var bird: String
    @State var isExpanded: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(bird).font(.headline)
                Spacer()
                Image(systemName: "arrow.up.circle").rotationEffect(.degrees(isExpanded ? 0 : 180))
            }
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tortor nunc, venenatis ut fringilla eu, venenatis sed elit. Phasellus sagittis ullamcorper consequat. Morbi laoreet tristique arcu vitae consequat. Mauris id laoreet quam. Sed tincidunt eget ligula id lobortis. Morbi vestibulum sit amet orci at dictum. Morbi sed sollicitudin nibh, tincidunt imperdiet ipsum. Nullam auctor sed sem eget condimentum. Sed porta odio in cursus scelerisque.")
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(isExpanded ? nil : 3)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(Colors.purpleColor))
        .cornerRadius(10)
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }

    }
}



/*
struct BirdsView: View, Equatable {
    @Binding var animals: [String]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(animals, id: \.self) { bird in
                Text(bird)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .padding()
            }
        }.frame(maxWidth: .infinity).background(Color.red)
    }

    static func == (lhs: Tab1.BirdsView, rhs: Tab1.BirdsView) -> Bool {
        lhs.animals.count == rhs.animals.count
    }
}

struct MammalsView: View, Equatable {
    @Binding var animals: [String]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(animals, id: \.self) { bird in
                Text(bird)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .padding()
            }
        }.frame(maxWidth: .infinity).background(Color.red)
    }

    static func == (lhs: Tab1.MammalsView, rhs: Tab1.MammalsView) -> Bool {
        lhs.animals.count == rhs.animals.count
    }
}
*/
