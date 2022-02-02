//
//  Double+Ext.swift
//  Books
//
//  Created by Gaurang on 07/01/22.
//

import Foundation

extension Double {
    func toCurrencyFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
