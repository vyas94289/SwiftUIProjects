//
//  OnboardingView.swift
//  FitnessApp
//
//  Created by Gaurang on 16/05/22.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 30) {
                        OnboardingSliderView(parentSize: proxy.size)
                        NavigationLink("Log in") {
                            LoginView()
                        }.buttonStyle(PrimaryButtonStyle(isLoading: .constant(false)))
                        HStack {
                            Text("Don’t have an Account? ")
                            NavigationLink(destination: {}, label: {
                                Text("Register")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                            })
                        }
                        Spacer()
                    }
                    
                }
            }.padding(20)
                .navigationBarHidden(true)
        }
    }
}

struct OnboardingSliderView: View {
    private let tabItems = SliderItem.all
    @State var selectedTab: Int = 0
    let parentSize: CGSize
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ForEach(0..<tabItems.count) { index in
                    OnboardSliderItemView(sliderItem: tabItems[index]).tag(index)
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: parentSize.width)
            HStack {
                Button(action: {
                    withAnimation {
                        selectedTab -= 1
                    }
                }, label: {
                    Image(app: .leftArrow)
                }).buttonStyle(NextPrevButtonStyle(lightStyle: true)).opacity(selectedTab > 0 ? 1 : 0)
                Spacer()
                ThemePageControl(selectedIndex: $selectedTab, itemCount: tabItems.count)
                Spacer()
                
                Button(action: {
                    withAnimation {
                        selectedTab += 1
                    }
                }, label: {
                    Image(app: .rightArrow)
                }).buttonStyle(NextPrevButtonStyle(lightStyle: false))
                    .opacity(selectedTab < tabItems.count - 1 ? 1 : 0)
                
            }
            
        }
    }
}

struct ThemePageControl: View {
    @Binding var selectedIndex: Int
    let itemCount: Int
    var body: some View {
        HStack {
            ForEach(0..<itemCount) { index in
                getColor(for: index)
                    .frame(width: 8, height: 8)
                    .clipShape(Circle())
                    .padding(2)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(1)
                    .background(selectedIndex == index ? Color(theme: .primaryLight) : Color.clear)
                    .clipShape(Circle())
            }
        }
    }
    
    func getColor(for index: Int) -> Color {
        if selectedIndex > index {
            return Color(theme: .primaryLight).opacity(0.5)
        } else if selectedIndex == index {
            return Color(theme: .primaryLight)
        } else {
            return Color(theme: .extraLightGray)
        }
    }
}

struct OnboardSliderItemView: View {
    let sliderItem: SliderItem
    var body: some View {
        VStack {
            Image(app: sliderItem.appImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 50)
            Text(sliderItem.title)
                .font(.title)
                .fontWeight(.semibold)
            Text(sliderItem.desc)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .contentShape(Rectangle())
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
