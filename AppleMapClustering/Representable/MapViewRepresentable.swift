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
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
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
        
        guard let plistURL = Bundle.main.url(forResource: "Data", withExtension: "plist") else {
            fatalError("Failed to resolve URL for `Data.plist` in bundle.")
        }

        do {
            let plistData = try Data(contentsOf: plistURL)
            let decoder = PropertyListDecoder()
            let decodedData = try decoder.decode(MapData.self, from: plistData)
            mapView.region = decodedData.region
            mapView.addAnnotations(decodedData.people)
        } catch {
            fatalError("Failed to load provided data, error: \(error.localizedDescription)")
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKClusterAnnotation {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation)
                view.clusteringIdentifier = "cluster"
                return view
            } else if annotation is Person {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
                view.clusteringIdentifier = "cluster"
                return view
            } else {
                return nil
            }
            
//            guard let annotation = annotation as? Person else { return nil }
//            
//            if annotation.memNo == -100 {
//                
//            } else {
//                
//            }
            
        }
    }
}
