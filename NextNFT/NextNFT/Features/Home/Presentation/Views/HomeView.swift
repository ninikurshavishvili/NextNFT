//
//  HomeView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI


struct HomeView: View {

    let viewModel: HomeViewModel
    let carouselViewModel: NFTCarouselViewModel

    var body: some View {
        ScrollView {
            HomeHeaderView()
            NFTItemListView()

            TrendingView(collections: viewModel.trendingState.value ?? [])

            switch viewModel.trendingState {
            case .idle, .loading:
                ProgressView("Loading collections...")
                    .foregroundStyle(.white)
                    .padding()
            case .failed(let message):
                Text("Error: \(message)")
                    .foregroundStyle(.red)
                    .padding()
            case .loaded, .empty:
                EmptyView()
            }
            NFTCarouselView(viewModel: carouselViewModel)
        }
        .background(AppColors.darkBackground)
        .task {
            await viewModel.loadIfNeeded()
        }


    }
}

#Preview {
    let container = AppContainer()
    HomeView(
        viewModel: container.makeHomeViewModel(),
        carouselViewModel: container.makeNFTCarouselViewModel()
    )
}

