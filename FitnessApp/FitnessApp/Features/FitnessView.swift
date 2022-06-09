//
//  FitnessView.swift
//  FitnessApp
//
//  Created by Gaurang on 13/05/22.
//

import SwiftUI

struct FitnessTask {
    let title: String
    let icon: Image
    let score: String
    let percentage: Int
}

extension FitnessTask {
    static var dummy: [FitnessTask] {
        return [
            .init(title: "Running", icon: Image(app: .running), score: "200 steps", percentage: 80),
            .init(title: "Hiking", icon: Image(app: .hiking), score: "3Mil", percentage: 90),
            .init(title: "Swim", icon: Image(app: .swim), score: "100 meter", percentage: 50),
        ]
    }
}

struct FitnessView: View {
    @Binding var showSideMenu: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top, spacing: 10) {
                            Text("Fitness Status").font(.title).fontWeight(.semibold)
                            Color(theme: .primary).clipShape(Circle()).frame(width: 10)
                            Spacer()
                        }
                        Text("You are very good in fitness!").font(.caption2).foregroundColor(.gray)
                    }
                    ForEach(FitnessTask.dummy, id: \.title) {
                        FitnessTaskView(fitnessTask: $0)
                    }
                }.padding()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Fitness")
            .addMenuButton(showSideMenu: $showSideMenu)
        }.navigationViewStyle(.stack)
    }
}

struct FitnessTaskView: View {
    let fitnessTask: FitnessTask
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var tick = 0
    @State private var indicatorWidthPercentage: CGFloat = 0
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                fitnessTask.icon
                Text(fitnessTask.title)
                Spacer()
                Text(fitnessTask.score)
            }
            Text("\(tick)%").font(.caption)
            GeometryReader { proxy in
                Color(theme: .primary)
                    .clipShape(Capsule())
                    .frame(width: (proxy.size.width * indicatorWidthPercentage) / 100)
            }.frame(height: 10).background(Color(theme: .primaryLight)).clipShape(Capsule())
        }
        .padding()
        .background(Color(theme: .primaryExtraLight))
        .cornerRadius(10)
        .foregroundColor(Color(theme: .primaryDark))
        .onAppear {
            withAnimation(.linear(duration: 0.025 * Double(fitnessTask.percentage))) {
                indicatorWidthPercentage = CGFloat(fitnessTask.percentage)
            }
        }
        .onReceive(timer) { _ in
            if (tick + 4) < fitnessTask.percentage {
                tick += 4
            } else {
                self.timer.upstream.connect().cancel()
                tick = fitnessTask.percentage
            }
        }
    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView(showSideMenu: .constant(false))
    }
}
