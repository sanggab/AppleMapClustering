//
//  ProfileAnnotationView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import UIKit
import MapKit

import SnapKit
import Then
import Kingfisher

class ProfileAnnotationView: MKAnnotationView {
    static let identifier: String = "ProfileAnnotationView"
    
    private var mainView: UIView = UIView().then {
        $0.backgroundColor = .clear
//        $0.layer.cornerRadius = 20
//        $0.layer.borderWidth = 2
//        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.clipsToBounds = true
    }
    
    private var profileImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
//    override var annotation: MKAnnotation? {
//        willSet {
//            if let cluster = annotation as? MKClusterAnnotation {
//                clusteringIdentifier = "cluster"
//            } else {
//                clusteringIdentifier = "marker"
//            }
//        }
//    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "profile"
        collisionMode = .circle
        
        frame = CGRect(x: 0, y: 0, width: 62, height: 62)
        centerOffset = CGPoint(x: 0, y: -10)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        setView()
        setConstraints()
    }
    
    private func setView() {
        self.addSubview(mainView)
        
        mainView.addSubview(profileImageView)
    }
    
    private func setConstraints() {
        mainView.snp.makeConstraints {
            $0.size.equalTo(62)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(info person: Person) {
        profileImageView.kf.setImage(with: URL(string: person.url))
        mainView.layer.cornerRadius = 31
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let annotations = clusterAnnotation.memberAnnotations
            
            if let person = annotations.first as? Person {
                configure(info: person)
            }
        } else {
            if let person = annotation as? Person {
                configure(info: person)            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        mainView.layer.cornerRadius = 0
        mainView.layer.borderWidth = 0
        mainView.layer.borderColor = UIColor.clear.cgColor
    }
}
