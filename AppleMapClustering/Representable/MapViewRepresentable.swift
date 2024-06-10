//
//  MapViewRepresentable.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import UIKit
import SwiftUI
import MapKit
import SnapKit
import Then
import Alamofire
import SwiftyJSON

struct MapViewRepresentable: UIViewRepresentable {
    var mapView = MKMapView()
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.mapType = .standard
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsBuildings = false
        mapView.delegate = context.coordinator
        
//        mapView.register(CustomMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(ProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(MyProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(MyProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        
        Task {
            let response = await AF.request(URL(string: "https://devapi-nadiu12.honeymatchs.com/api/v2/map/test/20000")!, method: .post).serializingData().response
            
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                let person: [Person] = try JSONDecoder().decode([Person].self, from: json.rawData())
                
                var slice = Array(person.prefix(1000))
                slice.insert(Person(latitude: 35.1595454, longitude: 126.8526012, url: "https://upload3.inven.co.kr/upload/2023/11/21/bbs/i16506236397.png", memNo: -100), at: 0)
                slice.insert(Person(latitude: 35.1995454, longitude: 126.8526012, url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Kdt054rNtjzZUa6FnHDuJ7JfTF_od5rTsA&s", memNo: -101), at: 1)
                
                mapView.addAnnotations(slice)
                
            case .failure(let error):
                print("error : \(error.localizedDescription)")
            }
        }
        
//        guard let plistURL = Bundle.main.url(forResource: "Data", withExtension: "plist") else {
//            fatalError("Failed to resolve URL for `Data.plist` in bundle.")
//        }
//
//        do {
//            let plistData = try Data(contentsOf: plistURL)
//            let decoder = PropertyListDecoder()
//            let decodedData = try decoder.decode(MapData.self, from: plistData)
//            mapView.region = decodedData.region
//            mapView.addAnnotations(decodedData.people)
//        } catch {
//            fatalError("Failed to load provided data, error: \(error.localizedDescription)")
//        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let cluster = annotation as? MKClusterAnnotation {
                guard let people = cluster.memberAnnotations as? [Person] else {
                    return nil
                }
                
                if people.contains(where: { $0.memNo == -100 }) {
                    let view = MyProfileAnnotationView(annotation: annotation, reuseIdentifier: MyProfileAnnotationView.identifier)
//                    view.clusteringIdentifier = "cluster"
                    return view
                } else {
                    let view = ProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
//                    view.clusteringIdentifier = "cluster"
                    return view
                }
                
                
            } else {
                guard let person = annotation as? Person else {
                    return nil
                }
                
                if person.memNo == -100 {
                    let view = MyProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
    //                view.clusteringIdentifier = "cluster"
                    return view
                } else {
                    let view = ProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
    //                view.clusteringIdentifier = "cluster"
                    return view
                }
            }
        }
        
//        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            print(#function)
//        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            print(#function)
            
            if let cluster = annotation as? MKClusterAnnotation {
                if let people = cluster.memberAnnotations as? [Person] {
                    print("people : \(dump(people))")
                }
            } else if let person = annotation as? Person {
                print("person : \(dump(person))")
                mapView.removeAnnotation(annotation)
            } else {
                print("안대!")
            }
        }
    }
}
