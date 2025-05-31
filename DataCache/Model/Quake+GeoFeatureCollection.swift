//
//  Quake+GeoFeatureCollection.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 27/05/2025.
//
import SwiftData
import OSLog

// A mapping from items in the feature collection to earthquake items.

extension Quake {
    
    // Creates a new quake instance from a decoded feature
    
    convenience init(from feature: GeoFeatureCollection.Feature) {
        self.init(code: feature.properties.code,
                  magnitude: feature.properties.mag,
                  time: feature.properties.time,
                  name: feature.properties.place,
                  longitude: feature.geometry.coordinates[0],
                  latitude: feature.geometry.coordinates[1])
    }
}

// helper method for loading feature data and storing it as quakes.

extension GeoFeatureCollection {
    
    fileprivate static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DataCache", category: "parsing")
    
    // load new earthquakes and delete outdated ones
    
    @MainActor
    static func referesh(modelContext: ModelContext) async {
        do {
            logger.debug("Refreshing the data store...")
            let featureCollection = try await fetchFeatures()
            logger.debug("Loaded feature collection:\n\(featureCollection)")
            
            // add the content to the data store.
            for feature in featureCollection.features {
                
                let quake = Quake(from: feature)
                
                // Ignore anything with a magnitude of zero or less.
                
                if quake.magnitude > 0 {
                    logger.debug("Inserting \(quake)")
                    modelContext.insert(quake)
                }
            }
            
            logger.debug("Refresh complete.")
        } catch let error {
            logger.error("\(error.localizedDescription)")
        }

    }
    
    
    
}
