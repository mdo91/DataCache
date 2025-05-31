//
//  DataCacheApp.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 26/05/2025.
//

import SwiftUI
import SwiftData

@main
struct DataCacheApp: App {
    @State private var viewModel: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
        .modelContainer(for: Quake.self)
    }
}
