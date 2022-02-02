//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 29/10/21.
//

import SwiftUI
enum Colors {
    static let darkColor = #colorLiteral(red: 0.0431372549, green: 0.07058823529, blue: 0.1843137255, alpha: 1)
    static let purpleColor = #colorLiteral(red: 0.4470588235, green: 0.1921568627, blue: 1, alpha: 1)
}

struct SplashView: View {
    @State var size: CGFloat = 100
    @State var showTabbar: Bool = false
    var body: some View {
        if showTabbar {
            ContentView()
        } else {
            ZStack {
                Color(Colors.darkColor)
                    .frame(width: size, height: size, alignment: .center)
                    .clipShape(Circle())
                    .animation(.easeOut(duration: 0.5))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(Colors.purpleColor))
            .ignoresSafeArea()
            .onAppear() {
                withAnimation {
                    size = UIScreen.main.bounds.height * 1.2
                }
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.4) {
                    self.showTabbar = true
                }
            }
        }

    }
}

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = Colors.darkColor
        }
    @State private var tabSelection = 3
    var body: some View {
        TabView(selection: $tabSelection) {
            Tab1(isBird: true).tabItem {
                Label("Birds", systemImage: "leaf")
            }.tag(1)
            Tab1(isBird: false).tabItem {
                Label("Mammals", systemImage: "tortoise")
            }.tag(2)
            ValidationView().tabItem {
                Label("Validaton", systemImage: "square.and.pencil")
            }.tag(3)

        }
        .accentColor(Color(Colors.purpleColor))
        .background(Color(Colors.darkColor).ignoresSafeArea())
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(ViewModel()).preferredColorScheme(.dark)
    }
}
