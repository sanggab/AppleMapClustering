//
//  MyProfileAnnotationView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/05.
//

import UIKit
import SwiftUI
import MapKit

import SnapKit
import Then
import Kingfisher

class MyProfileAnnotationView: MKAnnotationView {
    static let identifier: String = "MyProfileAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "myProfile"
        collisionMode = .circle
        
//        frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        bounds.size = CGSize(width: 66, height: 66)
//        centerOffset = CGPoint(x: 33, y: 33)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let annotations = clusterAnnotation.memberAnnotations
            
            if let person = annotations.first as? Person {
                let vc: UIHostingController = UIHostingController(rootView: MyProfileSUIView(imageUrl: person.url))
                
                vc.view.frame = bounds
                vc.view.backgroundColor = .clear
                
                self.addSubview(vc.view)
            }
        } else {
            if let person = annotation as? Person {
                let vc: UIHostingController = UIHostingController(rootView: MyProfileSUIView(imageUrl: person.url))
                
                vc.view.frame = bounds
                vc.view.backgroundColor = .clear
                
                self.addSubview(vc.view)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
