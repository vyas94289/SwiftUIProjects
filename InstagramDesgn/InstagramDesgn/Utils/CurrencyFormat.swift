//
//  CurrencyFormat.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 16/01/22.
//

import Foundation

extension Double {
    func toCurrencyFormate() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
