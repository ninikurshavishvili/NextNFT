//
//  Untitled.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.08.25.
//

import SwiftUI

struct TrendingView: View {
    @StateObject private var viewModel = CollectionsViewModel()
    
    @State private var selectedTab = "Collections"
    @State private var selectedIconIndex = 3
    @State private var selectedDay = "1D"
    
    let tabs = ["Collections", "Marketplaces"]
    let icons = ["square.stack.3d.up", "dollarsign.circle", "leaf.fill", "flame.fill", "bitcoinsign.circle"]
    let days = ["1H", "4H", "1D", "7D", "30D"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // — Your original trending UI —
                Text("Trending")
                    .font(.system(.title, design: .serif, weight: .bold))
                    .foregroundStyle(.white)

                // Tabs + Icons + Days... (unchanged)
                // 👇 Add your fetched data below
                if viewModel.isLoading {
                    ProgressView("Loading Collections...")
                        .foregroundStyle(.white)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else {
                    // ✅ Pass the fetched collections to your CollectionContainerListView
                    CollectionContainerListView(collections: viewModel.collections)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchCollections()
            }
        }
    }
}


#Preview {
    TrendingView()
        .background(AppColors.darkBackground)
}
