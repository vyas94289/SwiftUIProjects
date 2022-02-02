//
//  TagView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 13/01/22.
//

import SwiftUI

struct TagView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.yellow)
            .padding(5)
            .background(Color.primary)
            .cornerRadius(5)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "Yoga")
    }
}
