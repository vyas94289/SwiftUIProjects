//
//  SideMenu.swift
//  FitnessApp
//
//  Created by Gaurang on 11/05/22.
//

import SwiftUI

struct SideMenu<MenuContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    private let menuContent: () -> MenuContent
    
    public init(isShowing: Binding<Bool>,
                @ViewBuilder menuContent: @escaping () -> MenuContent) {
        _isShowing = isShowing
        self.menuContent = menuContent
    }
    
    func body(content: Content) -> some View {
        let drag = DragGesture().onEnded { event in
            if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
                withAnimation {
                    self.isShowing = event.translation.width > 0
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                content
                    .disabled(isShowing)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                menuContent()
              
                .transition(.move(edge: .leading))
                .offset(x: self.isShowing ? 0 : -geometry.size.width)
                
                if isShowing {
                    Color.white.opacity(0.01)
                        .frame(width: geometry.size.width / 2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isShowing = false
                            }
                        }.offset(x: geometry.size.width / 2)
                }
            }.gesture(drag)
        }
    }
}

extension View {
    func sideMenu(
        isShowing: Binding<Bool>) -> some View {
            self.modifier(SideMenu(isShowing: isShowing, menuContent: { SideMenuContent() }))
        }
}

struct SideMenuContent: View {
    @State var selectedItemIndex: Int = 0
    let menuItems: [ThemeTabItem] = [
        ThemeTabItem(icon: Image(app: .home), title: "Home"),
        ThemeTabItem(icon: Image(app: .bulb), title: "Tips & Tricks"),
        ThemeTabItem(icon: Image(app: .bell), title: "Notification"),
        ThemeTabItem(icon: Image(app: .camera), title: "Catch Snaps"),
        ThemeTabItem(icon: Image(app: .settings), title: "Settings"),
        ThemeTabItem(icon: Image(app: .message), title: "Feedback"),
        ThemeTabItem(icon: Image(app: .exit), title: "Exit Trip")
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(app: .avatar)
                HStack {
                    Text("Gaurang Vyas")
                    Button(action: {
                        
                    }, label: {
                        Image(app: .edit)
                    })
                }.padding(.bottom)
                ForEach(0..<menuItems.count) { index in
                    SideMenuItemView(item: menuItems[index],
                                     isSelected: Binding<Bool>(get: {
                        selectedItemIndex == index
                    }, set: { newValue in
                        if newValue {
                            self.selectedItemIndex = index
                        }
                    }))
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [Color(theme: .primaryDark), Color(theme: .primaryDark).opacity(0.7), Color.clear],
                                   startPoint: .leading, endPoint: .trailing)
                        .ignoresSafeArea())
        .foregroundColor(.white)
    }
}

struct SideMenuItemView: View {
    @EnvironmentObject var userSettings: UserSettings
    let item: ThemeTabItem
    @Binding var isSelected: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isSelected = true
                if item.title == "Exit Trip" {
                    userSettings.isLoggedIn = false
                }
            }
        }, label: {
            HStack {
                item.icon
                Text(item.title).font(.caption)
            }
        })
            .padding(.horizontal, isSelected ? 12 : 4)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? Color(theme: .primaryDark) : .white)
            .background(isSelected ? Color.white : Color.clear)
            .cornerRadius(8)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuContent()
    }
}
