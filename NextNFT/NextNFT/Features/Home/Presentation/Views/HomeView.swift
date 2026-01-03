//
//  HomeView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI


struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            HomeHeaderView()
            NFTItemListView()
            
            TrendingView(collections: viewModel.collections)

            if viewModel.isLoading {
                ProgressView("Loading collections...")
                    .foregroundStyle(.white)
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundStyle(.red)
                    .padding()
            }
        }
        .background(AppColors.darkBackground)
        .task {
            // ✅ async-safe, correct lifecycle
            if viewModel.collections.isEmpty {
                await viewModel.load()
            }
        }
    }
}


