//
//  ContentView.swift
//  OperationAndGCD
//
//  Created by Gaurang Vyas on 01/02/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var url = "https://pwdown.com/113587/variation/190K/Tera%20Hua%20-%20Arijit%20Singh.mp3"
    @FocusState private var focused
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    TextField("Paste URL Here..", text: $url)
                        .textFieldStyle(.roundedBorder)
                        .font(.subheadline)
                        .focused($focused)
                    Button(action: addTask, label: {
                        Text("Add")
                    })
                }.padding(.horizontal)
                ScrollView {
                    VStack(spacing: 4) {
                        ForEach(viewModel.downloadTaskList) { task in
                            DownloadView(task: task)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Downloader")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
        
    }
    
    private func addTask() {
        viewModel.addTask(urlStr: url)
        url = ""
        focused = false
    }
}

struct DownloadView: View {
    @ObservedObject var task: DownloadTask
    var body: some View {
        HStack {
            Image(systemName: "doc")
            VStack(alignment: .leading) {
                ProgressBar(progress: $task.process)
                Text(task.fileName).font(.caption)
                    .foregroundColor(.black)
            }
            Button(action: buttonAction) {
                Image(systemName: task.state.iconName)
                    .foregroundColor(Color(task.state.color))
            }.disabled(task.state == .completed)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(.blue)
    }
    
    func buttonAction() {
        if task.state == .running {
            task.pauseDownloading()
        } else if task.state == .paused {
            task.resumeDownloading()
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var body: some View {
        GeometryReader { proxy in
            Color.purple.opacity(0.3)
            Color.purple
                .frame(width: proxy.size.width * CGFloat(progress))
                .animation(.default, value: progress)
        }
        .frame(height: 10).clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
