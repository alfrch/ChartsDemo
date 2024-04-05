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
                Chart {
//                    ForEach(MockData.summary, id: \.category) { summary in
//                        ForEach(summary.data) {
//                            /// Bar Chart
//                            /// Vertical
////                            BarMark(
////                                x: .value("Phase", $0.phase),
////                                y: .value("Number of Tasks", $0.numberOfTasks)
////                            )
//                            
//                            /// Horizontal
//                            BarMark(
//                                x: .value("Number of Tasks", $0.numberOfTasks),
//                                y: .value("Phase", $0.phase)
//                            )
//                            .foregroundStyle(by: .value("Category", summary.category))
//                            .position(by: .value("Category", summary.category))
//                        }
//                    }
                    
                    ForEach(MockData.completedTasks) { item in
                        /// iOS 17
                        SectorMark(
                            angle: .value("Number of Tasks", item.numberOfTasks),
                            innerRadius: .ratio(0.6),
                            angularInset: 1
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Project Charts")
        }
    }
}

#Preview {
    ContentView()
}

struct ProjectTracker: Identifiable {
    var id: UUID = .init()
    var phase: String
    var numberOfTasks: Int
}

struct MockData {
    static let plannedTasks: [ProjectTracker] = [
        .init(phase: "Planning", numberOfTasks: 8),
        .init(phase: "Development", numberOfTasks: 15),
        .init(phase: "Testing", numberOfTasks: 10),
        .init(phase: "Deployment", numberOfTasks: 5),
    ]
    
    static let completedTasks: [ProjectTracker] = [
        .init(phase: "Planning", numberOfTasks: 7),
        .init(phase: "Development", numberOfTasks: 10),
        .init(phase: "Testing", numberOfTasks: 5),
        .init(phase: "Deployment", numberOfTasks: 5),
    ]
    
    static let summary = [
        (category: "Planned Tasks", data: plannedTasks),
        (category: "Completed Tasks", data: completedTasks),
    ]
}
