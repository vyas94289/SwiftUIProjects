//
//  ContentView.swift
//  Books
//
//  Created by Gaurang on 28/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab, content: {
            DashboardView().tabItem {
                Label("Dashboard", systemImage: "books.vertical")
            }.tag(0)
            PurchageHistoryView().tabItem {
                Label("Purchase History", systemImage: "cart")
            }.tag(1)
            AddBookView(selectedTab: $selectedTab).tabItem {
                Label("Add Book", systemImage: "text.book.closed")
            }.tag(2)
        })
    }
}

/*private func addItem() {
 withAnimation {
 let newItem = Item(context: viewContext)
 newItem.timestamp = Date()

 do {
 try viewContext.save()
 } catch {
 // Replace this implementation with code to handle the error appropriately.
 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 let nsError = error as NSError
 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
 }
 }
 }

 private func deleteItems(offsets: IndexSet) {
 withAnimation {
 offsets.map { items[$0] }.forEach(viewContext.delete)

 do {
 try viewContext.save()
 } catch {
 // Replace this implementation with code to handle the error appropriately.
 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 let nsError = error as NSError
 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
 }
 }
 }
 }*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
