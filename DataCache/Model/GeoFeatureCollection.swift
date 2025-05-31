//
//  GeoFeatureCollection.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 27/05/2025.
//

import Foundation
/// A container that decodes a feature collection from the server.
///
/// This structure decodes JSON with the following layout:
///
/// ```json
/// {
///    "features": [
///          {
///       "properties": {
///         "mag": 1.9,
///         "place": "21km ENE of Honaunau-Napoopoo, Hawaii",
///         "time": 1539187727610,
///         "code": "70643082"
///       },
///       "gemoetry": {
///         "coordinates": [63.2, -150.9, 5.2]
///       }
///     }
///   ]
/// }
/// ```
///
struct GeoFeatureCollection: Decodable {
    let features: [Feature]
    
    struct Feature: Decodable {
        let properties: Properties
        let geometry: Geometry
        
        struct Properties: Decodable {
            let mag: Double
            let place: String
            let time: Date
            let code: String
        }
        
        struct Geometry: Decodable {
            let coordinates: [Double]
        }
    }
}

extension GeoFeatureCollection.Feature: CustomStringConvertible {
    var description: String {
        """
        feature: {
            properties: {
                mag: \(properties.mag),
                place: \(properties.place),
                time: \(properties.time),
                code: \(properties.code)
            },
            geometry: { coordinates: \(geometry.coordinates)}
        }
        """
    }
}
extension GeoFeatureCollection: CustomStringConvertible {
    var description: String {
        var description = "Empty feature collection."
        if let feature = features.first {
            description = feature.description
            if features.count > 1 {
                description += "\n...and \(features.count - 1) more."
            }
        }
        return description
    }
}

extension GeoFeatureCollection {
    
    // get and decode latest earthquake data from the server
    
    static func fetchFeatures() async throws -> GeoFeatureCollection {
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
        
        let session = URLSession.shared
        guard let (data, response) = try? await session.data(from: url),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DownloadError.missingData
        }
        
        do {
            let jSONDecoder = JSONDecoder()
            jSONDecoder.dateDecodingStrategy = .millisecondsSince1970
            return try jSONDecoder.decode(GeoFeatureCollection.self, from: data)
        } catch {
            throw DownloadError.wrongDataFormat(error: error)
        }
    }
}

enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
}
