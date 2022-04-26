//
//  DateFormat.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Foundation

enum DateFormatHelper: String {
    case fullDate       = "dd MMMM, yyyy"

    var dateFormatter: DateFormatter {
        let dateformat = DateFormatter()
        dateformat.locale = .current
        dateformat.dateFormat = self.rawValue
        return dateformat
    }

    func getDateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }

}
