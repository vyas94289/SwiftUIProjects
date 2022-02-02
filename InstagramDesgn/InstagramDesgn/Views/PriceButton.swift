//
//  PriceButton.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 16/01/22.
//

import SwiftUI

struct PriceButton: View {
    let price: Double
    let onClick: EmptyClosure
    var body: some View {
        Button(action: onClick) {
            ZStack(alignment: .topLeading) {
                Text("+").font(.caption)
                Text(price.toCurrencyFormate())
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
            }.foregroundColor(.yellow)
                .padding(.horizontal, 2)
                .background(Color.black)
                .cornerRadius(3)
        }.buttonStyle(GrowingButton())
    }
}

struct PriceButton_Previews: PreviewProvider {
    static var previews: some View {
        PriceButton(price: 13.75, onClick: {
            
        })
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
