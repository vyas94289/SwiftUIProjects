//
//  AddBookView.swift
//  Books
//
//  Created by Gaurang on 29/12/21.
//

import SwiftUI
import Combine

struct AddBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var bookName: String = ""
    @State var bookAuthor: String = ""
    @State var bookPrice: String = ""
    @State var bookSynopsis: String = ""
    @State var bookQuantity: Int = 1
    @State var bookDescription: String = ""
    @Binding var selectedTab: Int

    var body: some View {
        NavigationView {
            Form {
                TextFieldSection(title: "Book Name",
                                 placeholder: "Enter book name",
                                 value: $bookName)
                TextFieldSection(title: "Book Author",
                                 placeholder: "Enter author's name",
                                 value: $bookAuthor)
                TextFieldSection(title: "Book Price",
                                 placeholder: "Enter book's price",
                                 value: $bookPrice).keyboardType(.decimalPad)
                TextFieldSection(title: "Book Synopsis",
                                 placeholder: "Enter book's synonpsis",
                                 isRequired: false,
                                 value: $bookSynopsis)
                Section(header: Text("Book Quantity")) {
                    Stepper("\(bookQuantity)", onIncrement: {
                        bookQuantity += 1
                    }, onDecrement: {
                        if bookQuantity > 1 {
                            bookQuantity -= 1
                        }
                    })
                }

                TextEditorSection(title: "Book Description", placeholder: "Enter book's description", value: $bookDescription)

            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: addBook)
                        .disabled(isValid == false)
                }
            }
            .onReceive(Just(bookSynopsis)) { _ in limitText(10) }
            .onReceive(Just(bookDescription)) { _ in wordLimit(300) }

        }
    }

    func limitText(_ upper: Int) {
        if bookSynopsis.count > upper {
            bookSynopsis = String(bookSynopsis.prefix(upper))
        }
    }

    func wordLimit(_ limit: Int) {
        let array = bookDescription.split(separator: " ")
        if array.count > limit {
            bookDescription = array.dropLast().joined(separator: " ")
        }
    }

    var isValid: Bool {
        return [bookName, bookAuthor, bookPrice, bookDescription].filter({$0.isEmpty}).isEmpty
    }


    private func addBook() {
        let newItem = Book(context: viewContext)
        newItem.name = bookName
        newItem.author = bookAuthor
        newItem.price = Double(bookPrice) ?? 0
        newItem.quantity = Int64(bookQuantity)
        newItem.synopsis = bookSynopsis
        newItem.desc = bookDescription
        do {
            try viewContext.save()
            selectedTab = 0
            clearForm()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func clearForm() {
        bookName = ""
        bookAuthor = ""
        bookPrice = ""
        bookSynopsis = ""
        bookDescription = ""
    }

}
