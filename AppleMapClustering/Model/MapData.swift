//
//  MapData.swift
//  AppleMapClustering
//
//  Created by Gab on 2024/06/04.
//

import MapKit
import CoreLocation

struct MapData: Decodable, Equatable {
    let people: [Person]

    let centerLatitude: CLLocationDegrees
    let centerLongitude: CLLocationDegrees
    let latitudeDelta: CLLocationDegrees
    let longitudeDelta: CLLocationDegrees

    var region: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        return MKCoordinateRegion(center: center, span: span)
    }
}
