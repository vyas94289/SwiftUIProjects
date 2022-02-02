//
//  InstaViewModel.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 13/01/22.
//

import Combine
import CoreGraphics

class InstaViewModel: ObservableObject {
    @Published var title = "Power yoga"
    @Published var dateTime = "3 Sep 2019, Tue 9.00 pm, 7 mins."
    @Published var tags: [String] = ["Yoga", "Strength Training"]
    @Published var desc: String  = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer luctus malesuada egestas. Nulla lobortis lacinia ligula quis maximus. Aliquam volutpat blandit mi nec ullamcorper. Morbi efficitur luctus dolor, efficitur elementum libero condimentum sed. Nam rutrum eu nisl sit amet tempus. Ut lacinia viverra ante, nec facilisis urna fringilla sit amet."
    @Published var rating: CGFloat = 4.5
    @Published var totalReviews = "(110 Reviews)"
    @Published var videoLinks = VideoLink.fromJsonFile
    @Published var originalPrice: Double = 25
    @Published var discountPrice: Double = 13.75
    @Published var discountPercentage: Int = 45
    @Published var packages = PackageInfo.fromJsonFile
}
