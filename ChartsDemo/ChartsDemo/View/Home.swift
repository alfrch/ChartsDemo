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
    @State private var barSelection: String?
    
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
                
                if let barSelection {
                    RuleMark(x: .value("Month", barSelection))
                        .foregroundStyle(.gray.opacity(0.35))
                        .zIndex(-10) // use zIndex to put rule mark behind the charts
                        .offset(yStart: -10)
                        .annotation(
                            position: .top,
                            spacing: 0,
                            overflowResolution: .init(x: .fit, y: .disabled)) {
                                if let downloads = appDownloads.findDownloads(barSelection) {
                                    chartPopoverView(downloads, barSelection)
                                }
                            }
                }
            }
            .chartXSelection(value: $barSelection) // iOS 17+ modifiers natively allow us to capture the chart selection, they even allow us to select the chart range.
            .chartLegend(position: .bottom, alignment: graphType == .bar ? .leading : .center, spacing: 25)
            .frame(height: 300)
            .padding(.top, 15)
            .animation(.snappy, value: graphType)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
    
    /// Chart Popoever View
    @ViewBuilder
    func chartPopoverView(_ downloads: Double, _ month: String) -> some View {
        VStackLayout(alignment: .leading, spacing: 6) {
            Text("App Downloads")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(spacing: 4) {
                Text(String(format: "%.0f", downloads))
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(month)
                    .font(.title3)
                    .textScale(.secondary)
            }
        }
        .padding()
        .background(Color("PopupColor"), in: .rect(cornerRadius: 8))
    }
}

#Preview {
    ContentView()
}
