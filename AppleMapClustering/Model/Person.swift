//
//  Person.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import Foundation
import MapKit

class Person: NSObject, Codable, MKAnnotation {
    var latitude: CLLocationDegrees = .zero
    var longitude: CLLocationDegrees = .zero
    
//    var number: Int
    var url: String
    var memNo: Int
    
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, url: String, memNo: Int) {
        self.latitude = latitude
        self.longitude = longitude
        self.url = url
        self.memNo = memNo
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
//        self.longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
//        self.url = try container.decode(String.self, forKey: .url)
//    }
}

enum ClusterID: Hashable {
    static var id = "clusterID"
}
