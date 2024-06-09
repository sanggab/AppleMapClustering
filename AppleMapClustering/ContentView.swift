//
//  ContentView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import SwiftUI
import Alamofire
import Kingfisher

struct ContentView: View {
    
//    @State private var mapData: [Person] = []
    
    var body: some View {
        MapViewRepresentable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        KingfisherManager.shared.cache.clearCache()
                    }
                    .padding(.bottom, 30)
            }
    }
}

#Preview {
    ContentView()
}
