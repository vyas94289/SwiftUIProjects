//
//  SliderItem.swift
//  FitnessApp
//
//  Created by Gaurang on 16/05/22.
//

import Foundation
struct SliderItem: Identifiable {
    let id = UUID()
    let title, desc: String
    let appImage: AppImage
    
    static var all: [SliderItem] {
        [.init(title: "Your Tasks", desc: "I always reminds you about your planned activities. which is always my priority and your importance.", appImage: .collaboration),
         .init(title: "Capture Your Memories", desc: "We know that catching photos are necessary in your trip. that’s why we have built-in camera and gallery feature.", appImage: .moments),
         .init(title: "Track Your Fitness", desc: "Fitness is one of the main thing which is really inportant to your body and we track it in every second.", appImage: .activityTracker),
         .init(title: "There Is Much More", desc: "We have bunch of other cool features. which is super helpful for your next camping trip. so what are you waiting for?", appImage: .camping)]
    }
}
