//
//  ViewModel.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 27/05/2025.
//
// User interface configuration values

import Foundation
import SwiftData

@Observable
class ViewModel {
    /// The parameter to oder quakes by in the list view
    
    var sortParameter: SortParameter = .time
    
    /// The sort direction for quakes in the list view.
    var sortOrder: SortOrder = .reverse
    
    /// the total number of quakes
    var totalQuakes: Int = 0
    
    /// A location name to use when filtering quakes.
    var searchText: String = ""
    
    /// Both the list and map views display only the quakes that occur between
    /// the start and end of the day in the current time zone that contain
    /// the point in the time represented by this date.
    var searchDate: Date = .now
    
    /// The range of dates that the date picker offers for filtering quakes.
    /// after loading new quakes or deleting existing ones, to
    /// include the full range of dates over all the stored quakes.
    var searchDateRange: ClosedRange<Date> = .distantPast ... .distantFuture
    
    /// Updates the search date and search date range based on the current
    /// set of stored quakes.
    
    func update(modelContext: ModelContext) {
        searchDateRange = Quake.dateRange(modelContext: modelContext)
        searchDate = min(searchDateRange.upperBound, .now)
        totalQuakes = Quake.totalQuake(modelContext: modelContext)
    }
    
}
