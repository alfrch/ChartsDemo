//
//  ContentView.swift
//  ChartsDemo
//
//  Created by Alif R on 01/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Temporary Title")
        }
    }
}

#Preview {
    ContentView()
}
