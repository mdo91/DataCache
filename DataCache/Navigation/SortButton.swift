//
//  SortButton.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 27/05/2025.
//

import SwiftUI

// A button that people can use to set the sort criteria.

struct SortButton: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        Menu {
            Picker("Sort Order", selection: $viewModel.sortOrder) {
                ForEach([ SortOrder.forward, .reverse], id: \.self) { order in
                    Text(order.name)
                    
                }
            }
            Picker("Sort By", selection: $viewModel.sortParameter) {
                ForEach(SortParameter.allCases) { parameter in
                    Text(parameter.name)
                    
                }
            }
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
        }
        .pickerStyle(.inline)
    }
}

extension SortOrder {
    /// A name for the sort order in the user interface
    var name: String {
        switch self {
        case .reverse: return "Reverse"
        case .forward: return "Forward"
        }
    }
}

/// The characteristics by which the app can sort earthquake data.
enum SortParameter: String, CaseIterable, Identifiable {
    case time, magnitude
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

#Preview {
    SortButton()
        .environment(ViewModel())
}
