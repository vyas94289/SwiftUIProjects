//
//  ViewModel.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 29/10/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var birds: [String] = ["Parrot", "Sparrow", "Hen"]
    @Published var mammals: [String] = ["Rat", "Dog", "Cat"]

    public var objectDidChange = ObservableObjectPublisher()
    
    func addBird(_ name: String) {
        birds.append(name)
    }

    func addMammal(_ name: String) {
        mammals.append(name)
    }
}
