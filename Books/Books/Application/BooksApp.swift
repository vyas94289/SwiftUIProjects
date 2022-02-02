//
//  BooksApp.swift
//  Books
//
//  Created by Gaurang on 28/12/21.
//

import SwiftUI

@main
struct BooksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
