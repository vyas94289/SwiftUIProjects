//
//  VideoThumbImage.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 15/01/22.
//

import SwiftUI

struct VideoThumbImage: View {
    let url: URL
    let onClick: () -> Void
    var body: some View {
        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .overlay {
                        Button(action: onClick) {
                            Image(.play)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                Image(systemName: "wifi.slash")
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
       
    }
}

