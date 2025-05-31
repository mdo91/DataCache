//
//  ContentView.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 26/05/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) private var scenePhase
    
    @Query private var quakes: [Quake]
    
    @State private var selectedId: Quake.ID? = nil
    @State private var selectedIdMap: Quake.ID? = nil

    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationSplitView {
            QuakeList(selectedId: $selectedId,
                      selectedIdMap: $selectedIdMap,
                      searchText: viewModel.searchText,
                      searchDate: viewModel.searchDate,
                      sortParameter: viewModel.sortParameter,
                      sortOrder: viewModel.sortOrder)
            .searchable(text: $viewModel.searchText)
            .toolbar {
                #if os(macOS)
                RefreshButton()
                #endif
            }
            // This modifier creates a pull-to-referesh in iOS, but also sets
            // the referesh action in the environment, which the custom macOS
            // RefreshButton uses.
            .refreshable {
                await GeoFeatureCollection.referesh(modelContext: modelContext)
                viewModel.update(modelContext: modelContext)
            }
            .navigationTitle("Earthquakes")
        } detail: {
            MapView(selectedId: $selectedId,
                    selectedIdMap: $selectedIdMap,
                    searchDate: viewModel.searchDate,
                    searchText: viewModel.searchText)
            #if os(macOS)
            .navigationTitle(quakes[selectedId]?.location.name ?? "Earthquakes")
            .navigationSubtitle(quakes[selectedId]?.fullDate ?? "")
            #else
            .navigationTitle(quakes[selectedId]?.location.name ?? "")
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        .onChange(of: scenePhase) { _, scenePhase in
            if scenePhase == .active {
                viewModel.update(modelContext: modelContext)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
