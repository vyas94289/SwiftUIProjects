//
//  SafeAreaView.swift
//  FitnessApp
//
//  Created by Gaurang on 18/05/22.
//

import SwiftUI

struct SafeAreaView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("user-1")
                .resizable( resizingMode: .stretch)
                .aspectRatio(1, contentMode: .fit)
            Spacer()
        }
    }
}

struct SafeAreaView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaView()
    }
}
