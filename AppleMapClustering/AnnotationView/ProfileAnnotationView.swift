//
//  ProfileAnnotationView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import UIKit
import SwiftUI
import MapKit

import SnapKit
import Then
import Kingfisher

class ProfileAnnotationView: MKAnnotationView {
    static let identifier: String = "ProfileAnnotationView"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "profile"
        collisionMode = .rectangle
        
        frame = CGRect(x: 0, y: 0, width: getSize().width, height: getSize().height)
        centerOffset = CGPoint(x: getSize().width / 2, y: getSize().height / 2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSize() -> CGSize {
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let annotations = clusterAnnotation.memberAnnotations
            
            let digit: Int = String(annotations.count * 5).count
//            print("digit: \(digit)")
            let firstCondi: Int = 49
            let borderWidth: Int = 3
            let leadingPadding: Int = 2
            
            let common: Int = firstCondi + borderWidth + leadingPadding
            
            switch digit {
            case 1:
                return CGSize(width: common + 30, height: 66)
            case 2:
                return CGSize(width: common + 30, height: 66)
            case 3:
                return CGSize(width: common + 36, height: 66)
            default:
                return CGSize(width: common + 44, height: 66)
            }
            
            
        } else {
            return CGSize(width: 66, height: 66)
        }
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let annotations = clusterAnnotation.memberAnnotations
            if let person = annotations.first as? Person {
//                frame.size = getSize()
                let vc: UIHostingController = UIHostingController(rootView: ProfileSUView(count: annotations.count, imageUrl: person.url))
                self.addSubview(vc.view)
            }
        } else {
            if let person = annotation as? Person {
//                frame.size = getSize()
                let vc: UIHostingController = UIHostingController(rootView: ProfileSUView(count: 0, imageUrl: person.url))
                self.addSubview(vc.view)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
