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
//            .onAppear {
//                AF.request(URL(string: "https://devapi-nadiu12.honeymatchs.com/api/v2/map/test/600")!, method: .post)
//                    .responseDecodable(of: [Person].self) { response in
//                        switch response.result {
//                        case .success(let data):
//                            mapData = data
//                        case .failure(let error):
//                            print("error : \(error)")
//                        }
//                    }
//            }
//            .onChange(of: mapData) { newValue in
//                print("mapData count : \(newValue.count)")
//            }
    }
}

#Preview {
    ContentView()
}
