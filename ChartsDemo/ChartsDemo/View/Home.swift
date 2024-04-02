//
//  Home.swift
//  ChartsDemo
//
//  Created by Alif R on 01/04/24.
//

import SwiftUI
import Charts

struct Home: View {
    /// View Properties
    @State private var graphType: GraphType = .donut
    
    var body: some View {
        VStack {
            /// Segmented Picker
            Picker("", selection: $graphType) {
                ForEach(GraphType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            /// Charts
            Chart {
                ForEach(appDownloads.sorted(by: { graphType == .bar ? false : $0.downloads > $1.downloads })) { download in
                    if graphType == .bar {
                        /// Bar Chart
                        BarMark(
                            x: .value("Month", download.month),
                            y: .value("Downloads", download.downloads)
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                    } else {
                        /// NEW API iOS 17+
                        /// Pie/Donut Chart
                        SectorMark(
                            angle: .value("Downloads", download.downloads),
                            innerRadius: .ratio(graphType == .donut ? 0.61 : 0), // innderRadius allows us to craete donut charts; you can apply innerRadius in the form of a ratio too.
                            angularInset: graphType == .donut ? 6 : 1 // angularInset applies the given spacing to the pie chart content.
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                    }
                }
            }
            .chartLegend(position: .bottom, alignment: graphType == .bar ? .leading : .center, spacing: 25)
            .frame(height: 300)
            .padding(.top, 15)
            .animation(.snappy, value: graphType)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
