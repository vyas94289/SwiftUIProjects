//
//  DashboardView.swift
//  Books
//
//  Created by Gaurang on 29/12/21.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Book.entity(), sortDescriptors: [], animation: .default)
    private var bookArray: FetchedResults<Book>
    var body: some View {
        NavigationView {
            // LazyVStack won't load records once, it's work same like "List"
            ScrollView {
                LazyVStack {
                    ForEach(bookArray) { book in
                        BookCellView(book: book)
                    }
                }
            }
            .background(Color(.secondarySystemBackground).ignoresSafeArea()).navigationTitle("Dashboard")
        }
    }
}


struct BookCellView: View {
    let book: Book
    @State var isExpanded: Bool = false
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(book.name ?? "")
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Text("Purchase")
                        Image(systemName: "cart.badge.plus")
                    }.font(.caption).foregroundColor(.white)
                })
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(.darkGray)).clipShape(Capsule())
            }
            Group {
                Text("Author Name: ").foregroundColor(.init(.secondary))
                    + Text(book.author ?? "")
                Text("Price: ").foregroundColor(.init(.secondary))
                    + Text(book.price.toCurrencyFormat())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline)

            HStack {
                Text(book.desc ?? "")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(isExpanded ? nil : 3)
                Spacer()
                Image(systemName: "arrow.up.circle").rotationEffect(.degrees(isExpanded ? 0 : 180))
            }

        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }

    }
}

/*struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCellView()
    }

    
}
*/
