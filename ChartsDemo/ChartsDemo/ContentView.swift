//
//  ContentView.swift
//  ChartsDemo
//
//  Created by Alif R on 01/04/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(MockData.plannedTasks) { sprint in
                    BarMark(
                        x: .value("Phase", sprint.phase),
                        y: .value("abc", sprint.numberOfTasks)
                    )
                }
            }
            .navigationTitle("Sprint Tracker")
        }
    }
}

#Preview {
    ContentView()
}

struct Sprint: Identifiable {
    var id: UUID = .init()
    var phase: String
    var numberOfTasks: Int
}

struct MockData {
    static let plannedTasks: [Sprint] = [
        .init(phase: "Planning", numberOfTasks: 8),
        .init(phase: "Development", numberOfTasks: 15),
        .init(phase: "Testing", numberOfTasks: 10),
        .init(phase: "Deployment", numberOfTasks: 5),
    ]
    
    static let completedTasks: [Sprint] = [
        .init(phase: "Planning", numberOfTasks: 7),
        .init(phase: "Development", numberOfTasks: 10),
        .init(phase: "Testing", numberOfTasks: 5),
        .init(phase: "Deployment", numberOfTasks: 5),
    ]
}
