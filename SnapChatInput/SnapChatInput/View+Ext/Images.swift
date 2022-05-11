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
}

extension Image {
    init(app: AppImage) {
        self.init(app.rawValue)
    }
}
