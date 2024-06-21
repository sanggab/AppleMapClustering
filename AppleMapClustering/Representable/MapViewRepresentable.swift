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

import CoreLocation

struct MapViewRepresentable: UIViewRepresentable {
    var mapView = MKMapView()
    
    let geocoder = CLGeocoder()
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.mapType = .standard
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsBuildings = false
        mapView.delegate = context.coordinator
        
        // 나의 프로필은 클러스털링 될 일은 없지만 viewFor delegate에서 id의 문제로 인해 등록해주어야함
        mapView.register(ProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(MyProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(MyProfileAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // 최초 실행 시, 내 지역값으로 region 설정 / 50배 줌
        if let coordinate = CLLocationManager().location?.coordinate {
            mapView.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
        }
        
        // 카메라 max, min 제한 추가
        mapView.cameraZoomRange = MKMapView.CameraZoomRange(
                    minCenterCoordinateDistance: 4500,
                    maxCenterCoordinateDistance: 15000000)
        
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
                    return view
                } else {
                    let view = ProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
                    return view
                }
                
                
            } else {
                guard let person = annotation as? Person else {
                    return nil
                }
                
                if person.memNo == -100 {
                    let view = MyProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
                    return view
                } else {
                    let view = ProfileAnnotationView(annotation: annotation, reuseIdentifier: ProfileAnnotationView.identifier)
                    return view
                }
            }
        }
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            print("didSelect annotation")
            
            if let cluster = annotation as? MKClusterAnnotation {
                if let people = cluster.memberAnnotations as? [Person] {
                    print("people : \(dump(people))")
                }
            } else if let person = annotation as? Person {
                print("person : \(dump(person))")

            } else {
                print("안대!")
            }
        }
        
        func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
            if let cluster = annotation as? MKClusterAnnotation {
                if let people = cluster.memberAnnotations as? [Person] {
                    print("didDeselect people : \(dump(people))")
                }
            } else if let person = annotation as? Person {
                print("didDeselect person : \(dump(person))")
            } else {
                print("didDeselect 안대!")
            }
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            print("altitude : \(mapView.camera.altitude)")
            print("centerCoordinateDistance : \(mapView.camera.centerCoordinateDistance)")
        }
    }
}
