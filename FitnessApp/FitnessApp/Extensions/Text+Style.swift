//
//  Text+Style.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Foundation
import SwiftUI

struct ErrorTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.caption)
        .foregroundColor(.red)
        
    }
}


extension Text {
    
    func errorStyle() -> some View {
        modifier(ErrorTextModifier())
    }
}

