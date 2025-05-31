//
//  Locaction.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 26/05/2025.
//
import CoreLocation

// location on earth
struct Location: Codable {
    
    
    // string that describes the location
    var name: String
    
    var longitude: Double
    
    var latitude: Double
    
    // the longitude and latitude collected into a locatiion coordinate
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

// A string representation of the location

extension Location: CustomStringConvertible {
    var description: String {
        "["
        + longitude.formatted(.number.precision(.fractionLength(1)))
        + ", "
        + latitude.formatted(.number.precision(.fractionLength(1)))
        + "] "
        + name
    }
}
