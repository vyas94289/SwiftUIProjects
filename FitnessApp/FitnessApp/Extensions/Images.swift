//
//  Images.swift
//  FitnessApp
//
//  Created by Gaurang on 11/05/22.
//

import Foundation
import SwiftUI

enum AppImage: String {
    case activities = "ic_activity"
    case avatar = "ic_avatar"
    case bell = "ic_bel"
    case bulb = "ic_bulb"
    case camera = "ic_camera"
    case briefCase = "ic_case"
    case edit = "ic_edit"
    case exit = "ic_exit"
    case heart = "ic_heart"
    case home = "ic_home"
    case logo = "ic_logo"
    case menu = "ic_menu"
    case message = "ic_message"
    case refresh = "ic_refresh"
    case settings = "ic_settings"
    case team = "ic_team"
    case world = "ic_world"
    case running = "ic_running"
    case pushup = "ic_pushup"
    case hiking = "ic_hiking"
    case swim = "ic_swim"
    case activityTracker = "Activity_tracker"
    case addNotes = "Add_notes"
    case camping  = "camping_noc8"
    case collaboration = "Collaboration"
    case highFive = "High_five"
    case moments
    case undrawEmpty = "undraw_empty"
    case rightArrow = "ic_right_arrow"
    case leftArrow = "ic_arrow_left"
    case award = "ic_award"
}

extension Image {
    init(app: AppImage) {
        self.init(app.rawValue)
    }
}
