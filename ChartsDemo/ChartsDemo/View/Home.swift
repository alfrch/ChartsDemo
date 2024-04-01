//
//  Home.swift
//  ChartsDemo
//
//  Created by Alif R on 01/04/24.
//

import SwiftUI

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
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
