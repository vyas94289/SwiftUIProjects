//
//  TabBarView.swift
//  SnapChatInput
//
//  Created by Gaurang on 10/05/22.
//

import SwiftUI

struct AppTabBarView: View {
    @State var showSideMenu: Bool = false
    @State var selectedTab: Int = 0
    @State var hideTab: Bool = false
    private let tabItems: [ThemeTabItem] = [
        ThemeTabItem(icon: Image(app: .activities), title: "Activities"),
        ThemeTabItem(icon: Image(app: .heart), title: "Fitness"),
        ThemeTabItem(icon: Image(app: .briefCase), title: "BagPack"),
        ThemeTabItem(icon: Image(app: .team), title: "Teammates")
    ]
    lazy var activityView = ActivitiesView(showSideMenu: $showSideMenu)
    var body: some View {
        VStack(spacing: 0) {
            contentView.frame(maxWidth: .infinity, maxHeight: .infinity)
            if hideTab == false {
                ThemeTabBar(selectedItemIndex: $selectedTab, items: tabItems)
            }
        }.sideMenu(isShowing: $showSideMenu)
    }
    
    @ViewBuilder
    var contentView: some View {
        switch selectedTab {
        case 0:
             ActivitiesView(showSideMenu: $showSideMenu)
        case 1:
             FitnessView(showSideMenu: $showSideMenu)
        case 3:
             TeammatesView(hideTabBar: $hideTab, showSideMenu: $showSideMenu)
        default:
             Color.yellow
        }
    }
}

struct ThemeTabItem {
    let icon: Image
    let title: String
}

struct ThemeTabBar: View {
    @Binding var selectedItemIndex: Int
    let items: [ThemeTabItem]
    var body: some View {
        HStack {
            ForEach(0..<items.count) { index in
                Spacer()
                TabItemView(item: items[index],
                            isSelected: Binding<Bool>(get: {
                    selectedItemIndex == index
                }, set: { newValue in
                    if newValue {
                        self.selectedItemIndex = index
                    }
                }))
                Spacer()
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
        .background(Color(theme: .primary)
                        .edgesIgnoringSafeArea(.bottom))
    }
}

struct TabItemView: View {
    let item: ThemeTabItem
    @Binding var isSelected: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isSelected = true
            }
            
        }, label: {
            HStack {
                item.icon
                if isSelected {
                    Text(item.title).font(.caption)
                }
            }
        })
            .padding(8)
            .foregroundColor(.white)
            .background(Color.black.opacity(isSelected ? 0.3 : 0))
            .clipShape(Capsule())
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
