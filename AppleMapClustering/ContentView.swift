//
//  ContentView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapViewRepresentable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
