//
//  LocationsView.swift
//  FitnessApp
//
//  Created by Gaurang on 19/05/22.
//

import SwiftUI

struct LocationsView: View {
    let islands: [IslandModel] = IslandModel.getArrayModel(fromJsonFile: .islands)
    @State private var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $search)
                        .frame(height: 48)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(theme: .extraLightGray))
                        ).overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(theme: .lightGray).opacity(0.3), lineWidth: 1)
                        )
                        .foregroundColor(Color(theme: .darkGray))
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    }).buttonStyle(PrimaryButtonStyle(isLoading: .constant(false)))
                        .aspectRatio(1, contentMode: .fit)
                        
                }.padding(.horizontal)
                Spacer()
            }.navigationTitle("Locations")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
