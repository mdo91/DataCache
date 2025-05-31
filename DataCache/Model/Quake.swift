//
//  Quake.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 26/05/2025.
//

import SwiftUI
import SwiftData

// representation of an earthquake
@Model
class Quake {
    
    // uniqe identifier associated with earthquake event
    @Attribute(.unique) var code: String
    
    var magnitude: Double
    
    var time: Date
    
    var location: Location
    
    init(code: String,
         magnitude: Double,
         time: Date,
         name: String,
         longitude: Double,
         latitude: Double
    ) {
        self.code = code
        self.magnitude = magnitude
        self.time = time
        self.location = Location(name: name, longitude: longitude, latitude: latitude)
    }
    
}
// A convenience for accessing a quake in an array by its identifier.

extension Array where Element: Quake {
    subscript (id: Quake.ID?) -> Quake? {
        first { $0.id == id }
    }
}

// Values that the app uses to represent earthquakes in the interface

extension Quake {
    // Color that represents the quake's magnitude
    var color: Color {
        switch magnitude {
            case 0..<1:
            return .green
        case 1..<2:
            return .yellow
        case 2..<3:
            return .orange
        case 3..<5:
            return .red
        case 5..<7:
            return .purple
        case 7..<Double.greatestFiniteMagnitude:
            return .indigo
        default:
            return .gray
        
        }
    }
    
    // size for a marker that represents a quake on a map
    
    var markerSize: CGSize {
        let value = (magnitude + 3) * 6
        return CGSize(width: value, height: value)
    }
    
    var magnitudeString: String {
        magnitude.formatted(.number.precision(.fractionLength(1)))
    }
    
    // a complete representation of the event's data
    
    var fullDate: String {
        time.formatted(date: .complete, time: .complete)
    }
}

extension Quake: CustomStringConvertible {
    var description: String {
        "\(fullDate) \(magnitudeString) \(location)"
    }
}

extension Quake {
    /// A filter that checks for a date and text in the quake's location name
    ///
    static func predicate(searchText: String,
                          searchDate: Date) -> Predicate<Quake> {
        let calendar = Calendar.autoupdatingCurrent
        let start =  calendar.startOfDay(for: searchDate)
        let end = calendar.date(byAdding: .init(day: 1), to: start) ?? start
        
        return #Predicate<Quake> { quake in
            (searchText.isEmpty || quake.location.name.contains(searchText))
            &&
            (quake.time > start && quake.time < end)
            
        }
    }
    
    static func dateRange(modelContext: ModelContext) -> ClosedRange<Date> {
        let descriptor = FetchDescriptor<Quake>(sortBy: [.init(\.time, order: .forward)])
        guard let quakes = try? modelContext.fetch(descriptor),
              let first = quakes.first?.time,
              let last = quakes.last?.time
        else {
            return .distantPast ... .distantFuture
        }
        return first ... last
    }
    
    /// reports the total number of quakes
    static func totalQuake(modelContext: ModelContext) -> Int {
        (try? modelContext.fetchCount(FetchDescriptor<Quake>())) ?? 0
    }
}
extension Quake: Identifiable { }
