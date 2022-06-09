//
//  TeammateView.swift
//  FitnessApp
//
//  Created by Gaurang on 13/05/22.
//

import SwiftUI

struct TeammatesView: View {
    @Binding var hideTabBar: Bool
    @Binding var showSideMenu: Bool
    @State var showDetails: Bool = false
    @State var currentTeammate: TeammateModel!
    @Namespace private var animation
    @State var teammates: [TeammateModel] = TeammateModel.getArrayModel(fromJsonFile: .teammates)
    var body: some View {
        NavigationView {
            ZStack {
                List(teammates) { info in
                    TeammateItemView(animation: animation, info: info)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .onTapGesture {
                            withAnimation {
                                currentTeammate = info
                                showDetails = true
                            }
                        }
                }
                .listStyle(.plain)
                .opacity(showDetails ? 0 : 1)
                if showDetails {
                    TeammateDetailsView(animation: animation, isShowing: $showDetails, info: currentTeammate)
                }
            }
            .addMenuButton(showSideMenu: $showSideMenu)
            .navigationTitle("Teammates")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(showDetails)
            .onChange(of: showDetails) { newValue in
                withAnimation {
                    hideTabBar = newValue
                }
            }
            
        }.navigationViewStyle(.stack)
            
    }
}

struct TeammateItemView: View {
    var animation: Namespace.ID
    let info: TeammateModel
    var body: some View {
        HStack {
            Image("user-\(info.id)")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(20)
                .matchedGeometryEffect(id: info.id, in: animation, anchor: .center)
            VStack(alignment: .leading, spacing: 6) {
                Text(info.name).fontWeight(.medium)
                Text(info.occupation).foregroundColor(.gray).font(.caption)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct TeammateView_Previews: PreviewProvider {
    static var previews: some View {
        TeammatesView(hideTabBar: .constant(false), showSideMenu: .constant(false))
    }
}

