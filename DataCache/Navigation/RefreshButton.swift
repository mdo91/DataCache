//
//  RefreshButton.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 29/05/2025.
//
import SwiftUI

// A button that indicates the referesh action in the environment

/// This button relies on the refresh action, which you can put into the
/// environment by adding a refreshable modifier to the view hiearachy.

struct RefreshButton: View {
    
    @Environment(\.refresh) private var refresh
    
    var body: some View {
        Button {
            Task {
                await refresh?()
            }
        } label: {
            Label("Referesh", systemImage: "arrow.clockwise")
        }
    }
}

#Preview {
    RefreshButton()
}
