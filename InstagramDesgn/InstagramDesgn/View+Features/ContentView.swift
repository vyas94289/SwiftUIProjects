//
//  ContentView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 12/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = InstaViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                mainContent
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Class Details".uppercased())
                        .font(.custom(AppFont.bold, size: 20))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(.share)
                    }.foregroundColor(.primary)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("AppBackground").edgesIgnoringSafeArea(.bottom))
        }
    }
    
    var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(viewModel.title.uppercased()).font(.custom(AppFont.bold, size: 35))
                    Spacer()
                    Button(action: {}) {
                        Image(.bell)
                    }.foregroundColor(.primary)
                }
                Text(viewModel.dateTime).foregroundColor(.secondary).font(.subheadline)
                HStack(spacing: 8) {
                    ForEach(viewModel.tags, id: \.self) { title in
                        TagView(title: title)
                    }
                }
                Text(viewModel.desc)
                ratingContent
                locationInfo
                VideosGridView(videos: viewModel.videoLinks)
                classDetails
            }.padding(16)
        }
    }
    
    var ratingContent: some View {
        HStack {
            StarsView(rating: viewModel.rating, maxRating: 5)
                .frame(height: 14)
            Text(viewModel.totalReviews).foregroundColor(.gray)
                .font(.subheadline)
                .underline()
        }
    }
    
    var locationInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider().frame(width: 150)
            HStack(spacing: 15) {
                Text("tf")
                    .font(.title)
                    .fontWeight(.heavy)
                    .italic()
                    .padding(16)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(Circle())
                Group {
                    Text("with ").foregroundColor(.gray) +
                    Text("Ashley Knight\n") +
                    Text("at ").foregroundColor(.gray) +
                    Text("Boxer").underline()
                    
                }.font(.subheadline)
            }
            Divider().frame(width: 150)
        }
    }
    
    var classDetails: some View {
        VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.title.uppercased()).font(.custom(AppFont.bold, size: 18))
                    Text("1 class")
                }
                Spacer()
                HStack {
                    Text(viewModel.discountPrice.toCurrencyFormate()).foregroundColor(.gray)
                        .font(.subheadline)
                        .strikethrough()
                    PriceButton(price: viewModel.discountPrice, onClick: {})
                }
            }
            VStack(spacing: 0) {
                Text("Packages".uppercased()).font(.custom(AppFont.bold, size: 26))
                Text("Buy a package to save money").foregroundColor(.gray).font(.caption)
            }
            LazyVStack {
                ForEach(viewModel.packages) { package in
                    PackageCellView(packege: package)
                    Divider()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
