//
//  QuakeListInfo.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 30/05/2025.
//
import SwiftUI

struct QuakeListInfo: View {
    @Environment(ViewModel.self) private var viewModel
    
    var count: Int = 0
    
    var body: some View {
        @Bindable var viewModel = viewModel
        HStack {
            VStack {
                Text("\(count) earthquakes")
                Text("\(viewModel.totalQuakes) total")
                    .foregroundColor(.secondary)
            }
            .fixedSize()
            Spacer()

            DatePicker("Search Date",
                       selection: $viewModel.searchDate,
                       in: viewModel.searchDateRange,
                       displayedComponents: .date
            
            )
            .labelsHidden()
            .disabled(viewModel.totalQuakes == 0)
        }
    }
}

#Preview {
    QuakeListInfo(count: 8)
        .environment(ViewModel.preview)
}
