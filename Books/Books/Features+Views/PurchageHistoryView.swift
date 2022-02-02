//
//  PurchageHistoryView.swift
//  Books
//
//  Created by Gaurang on 29/12/21.
//

import SwiftUI

struct PurchageHistoryView: View {
    let totalSeats: Int = 1
    let totalSize: CGFloat = 200
    var circleSize: CGFloat  {
        totalSize / 2
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                ForEach(0..<totalSeats) { tick in
                    self.tick(at: tick)
                }

            }
            .frame(width: totalSize, height: totalSize, alignment: .center)
            .background(Color.gray)
        }
    }

    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .frame(width: 30, height: 30)
                .onTapGesture {
                    print(tick)
                }
            Spacer()
        }
        .background(Color.blue)

        .rotationEffect(Angle.degrees(Double(tick)/Double((totalSeats)) * 360))
    }
}

struct PurchageHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchageHistoryView()
    }
}
