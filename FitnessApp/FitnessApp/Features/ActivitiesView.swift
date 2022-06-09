//
//  ActivitiesView.swift
//  FitnessApp
//
//  Created by Gaurang on 11/05/22.
//

import SwiftUI

struct ActivitiesView: View {
    @Binding var showSideMenu: Bool
    @State var activities: [ActivityModel] = ActivityModel.getArrayModel(fromJsonFile: .activities)
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    HStack {
                        Text("01 Day").font(.title)
                        Spacer()
                        Text("16 day’s remain").font(.caption2).foregroundColor(.gray)
                    }.padding()
                    ForEach(activities) {
                        ActivityRowView(activity: $0)
                    }
                    Spacer()
                }
            }
            .navigationTitle("Activities")
            .navigationBarTitleDisplayMode(.inline)
            .addMenuButton(showSideMenu: $showSideMenu)
        }.navigationViewStyle(.stack)
    }
}

struct ActivityRowView: View {
    let activity: ActivityModel
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(activity.title).font(.callout).fontWeight(.semibold)
                Spacer()
                Text(activity.by).font(.caption2).foregroundColor(.gray)
            }
            
            Text(activity.comment)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .lineLimit(isExpanded ? nil : 2)
        }
        .padding()
        .background(Color(theme: .extraLightGray))
        .cornerRadius(10)
        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
        .onTapGesture {
            withAnimation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0)) {
                self.isExpanded.toggle()
            }
            
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(showSideMenu: .constant(false))
    }
}
