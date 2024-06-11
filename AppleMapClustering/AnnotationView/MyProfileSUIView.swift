//
//  MyProfileSUIView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/11.
//

import SwiftUI
import Kingfisher

struct MyProfileSUIView: View {
    var imageUrl: String
    
    var imageSize: CGSize = CGSize(width: 62, height: 62)
    
    let colors: [Color] = [
        Color(uiColor: UIColor(red: 255.0 / 255.0,
                               green: 224.0 / 255.0,
                               blue: 100.0 / 255.0,
                               alpha: 1)),
        
        Color(uiColor: UIColor(red: 255.0 / 255.0,
                               green: 245.0 / 255.0,
                               blue: 204.0 / 255.0,
                               alpha: 1)),
        
        Color(uiColor: UIColor(red: 248.0 / 255.0,
                               green: 215.0 / 255.0,
                               blue: 82.0 / 255.0,
                               alpha: 1))
    ]
    
    var body: some View {
        ZStack {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: imageSize.width, height: imageSize.width)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 3,
                                                         lineCap: .round,
                                                         lineJoin: .round))
                        .foregroundStyle(LinearGradient(colors: colors,
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing))
                }
                .shadow(color: .black.opacity(0.16), radius: 4, x: 0, y: 2)
                .padding(.all, 2)
            
            Image(uiImage: UIImage(named: "imgMapbadgeBoost")!)
                .alignmentGuide(HorizontalAlignment.center) { d in
                    return d[.trailing] + 9
                }
                .alignmentGuide(VerticalAlignment.center) { d in
                    return d[.bottom] + 9
                }
            
            Rectangle()
                .fill(.mint)
                .frame(width: 24, height: 16)
                .cornerRadius(4)
                .alignmentGuide(HorizontalAlignment.center) { d in
                    return d[.leading] - 9
                }
                .alignmentGuide(VerticalAlignment.center) { d in
                    return d[.top] - 17
                }
        }
//        .background(.gray)
    }
}

#Preview {
    MyProfileSUIView(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtfi01OjKa_kUGM6bew7AGs1yQVMQDTW3jUw&s")
}
