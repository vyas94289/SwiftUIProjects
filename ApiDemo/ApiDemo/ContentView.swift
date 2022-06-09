//
//  ContentView.swift
//  ApiDemo
//
//  Created by Gaurang on 07/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        List(viewModel.postList) { post in
            Text(post.title).swipeActions {
                Button("Delete") {
                    withAnimation {
                        viewModel.postList.removeAll(where: {$0.id == post.id})
                    }
                }.tint(Color.red)
                Button("Edit") {
                    print("Edit id \(post.id)")
                }.tint(Color.green)
            }
        }
        .task {
            viewModel.fetchPost()
        }.transition(.opacity)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
