//
//  MyProfileAnnotationView.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/05.
//

import UIKit
import MapKit

import SnapKit
import Then
import Kingfisher

class MyProfileAnnotationView: MKAnnotationView {
    static let identifier: String = "MyProfileAnnotationView"
    
    private var mainView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.clipsToBounds = true
    }
    
    private var profileImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
//    override var annotation: MKAnnotation? {
//        willSet {
//            if let annotation = newValue as? Person {
//                print("모모")
//                clusteringIdentifier = ClusterID.id
//                configure(info: annotation)
//            } else {
//                print("아니아니")
//            }
//        }
//    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        collisionMode = .circle
        
        frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        centerOffset = CGPoint(x: 0, y: -40)
        
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
            $0.size.equalTo(40)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(info person: Person) {
//        profileImageView.image = UIImage(named: "도화가\(person.number)")
        profileImageView.kf.setImage(with: URL(string: person.url))
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
//        configure(info: person)
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let annotations = clusterAnnotation.memberAnnotations
            
            if let person = annotations.first as? Person {
                configure(info: person)
            }
        } else {
            if let person = annotation as? Person {
                configure(info: person)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
}
