//
//  HomeView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: CollectionsViewModel

    var body: some View {
        VStack {
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
        }
        .background(AppColors.darkBackground)
        .onAppear {
            if viewModel.collections.isEmpty {
                    viewModel.fetchCollections()
                }
        }
    }
}


#Preview {
    HomeView(viewModel: CollectionsViewModel())
}

