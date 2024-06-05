//
//  Person.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import Foundation
import MapKit

class Person: NSObject, Decodable, MKAnnotation {
    var latitude: CLLocationDegrees = .zero
    var longitude: CLLocationDegrees = .zero
    
    var number: Int
    
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum ClusterID: Hashable {
    static var id = "clusterID"
}
