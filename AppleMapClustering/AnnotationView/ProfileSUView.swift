//
//  ProfileSUView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/11.
//

import SwiftUI

import Kingfisher

struct ProfileSUView: View {
    var count: Int
    var imageUrl: String
    
    var imageSize: CGSize = CGSize(width: 62, height: 62)
    
    var body: some View {
        ZStack {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: imageSize.width, height: imageSize.width)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 3,
                                                                     lineCap: .round,
                                                                     lineJoin: .round))
                }
                .shadow(color: .black.opacity(0.16), radius: 4, x: 0, y: 2)
                .padding(.all, 2)
            
            Image(uiImage: UIImage(named: "imgMapBadgeHeart")!)
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
            
            countView
                .shadow(color: .black.opacity(0.24), radius: 4, x: 0, y: 2)
                .alignmentGuide(HorizontalAlignment.center) { d in
                    return d[HorizontalAlignment.leading] - 21
                }
                .padding(.top, getTopPadding())
        }
    }
    
    @ViewBuilder
    var countView: some View {
        if count > 0 {
            Text(getCountText())
                .frame(width: getSize().width, height: getSize().height)
                .font(getFont())
                .background(.yellow)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
        } else {
            EmptyView()
        }
    }
    
    func getCountText() -> String {
        if count * 5 > 999 {
            return "999+"
        } else {
            return String(count * 5)
        }
    }
    
    func getFont() -> Font {
        let digit = String(count * 5).count
        
        switch digit {
        case 1:
            return .system(size: 13)
        case 2:
            return .system(size: 14)
        case 3:
            return .system(size: 15)
        default:
            return .system(size: 16)
        }
    }
    
    func getSize() -> CGSize {
        let digit = String(count * 5).count
        
        switch digit {
        case 1:
            return CGSize(width: 30, height: 30)
        case 2:
            return CGSize(width: 30, height: 30)
        case 3:
            return CGSize(width: 36, height: 36)
        default:
            return CGSize(width: 44, height: 44)
        }
    }
    
    func getTopPadding() -> CGFloat {
        return imageSize.height - getSize().height - 6
    }
}

#Preview {
    ProfileSUView(count: 1000,
                  imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRElZHHp5AzkFXd3DMEmSI0s2eiwaSjtkQ5NQ&s")
}
