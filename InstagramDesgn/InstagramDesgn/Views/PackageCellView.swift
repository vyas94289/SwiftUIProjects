//
//  PackageCellView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 16/01/22.
//

import SwiftUI

struct PackageCellView: View {
    let packege: PackageInfo
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(packege.name.uppercased()).font(.custom(AppFont.bold, size: 18))
                Text(packege.classCountString)
            }
            Spacer()
            PriceButton(price: packege.price, onClick: {})
        }
    }
}

struct PackageCellView_Previews: PreviewProvider {
    static var previews: some View {
        PackageCellView(packege: .fromJsonFile[0])
    }
}
