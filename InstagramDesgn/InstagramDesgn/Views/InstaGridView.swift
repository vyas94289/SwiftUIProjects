//
//  InstaGridView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 15/01/22.
//

import SwiftUI

struct VideosGridView: View {
    var videos: [[VideoLink]]
    init(videos: [VideoLink]) {
        var array: [[VideoLink]] = []
        var offset = 0
        for _ in 0..<(videos.count / 6) {
            var appendCount = 0
            var itemArray: [VideoLink] = []
            for index in offset ..< videos.count {
                itemArray.append(videos[index])
                appendCount += 1
                if appendCount == 6 {
                    break
                }
            }
            array.append(itemArray)
            offset = array.count * 6
        }
        let remainsLinksCount = videos.count % 6
        if remainsLinksCount > 0 {
            var itemArray: [VideoLink] = []
            for _ in 0..<remainsLinksCount {
                itemArray.append(videos[offset])
                array.append(itemArray)
                offset += 1
            }
        }
        
        self.videos = array
    }
    @State var totalSize: CGFloat = 100
    @State var selectedTab: Int = 0
    private let twoColumns = [
        GridItem(.flexible(minimum: 0), spacing: 4),
        GridItem(.flexible(minimum: 0), spacing: 4),
    ]
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Studio's Instagram".uppercased())
                Spacer()
                PageControl(numberOfPages: videos.count, currentPage: $selectedTab)
            }
            TabView(selection: $selectedTab) {
                ForEach((0..<videos.count), id: \.self) { index in
                    LazyHGrid(rows: twoColumns, spacing: 4) {
                        ForEach(videos[index]) { link in
                            ZStack {
                                VideoThumbImage(url: link.thumbUrl, onClick: {})
                                
                            }
                            .background(Color(UIColor.systemBackground))
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .tag(index)
                }
            }.frame(height: (totalSize / 3) * 2)
                .tabViewStyle(.page(indexDisplayMode: .never))
        }.background(GeometryReader { proxy in
            EmptyView().onChange(of: proxy.size) { newValue in
                totalSize = newValue.width
            }
        })
    }
}



let sectionColor: [Color] = [.red, .blue, .purple, .gray]
