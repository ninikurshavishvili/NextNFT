//
//  SearchPageView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 22.07.25.
//

import SwiftUI

struct SearchPageView: View {
    @Bindable var viewModel: SearchViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SearchHeaderView(balance: "42.80")
                
                SearchBarView(
                    text: $viewModel.searchText,
                    onClear: viewModel.clearSearch
                )
                
                SearchFilterChipsView(
                    selected: viewModel.searchType,
                    onSelect: viewModel.selectSearchType
                )
                
                if viewModel.searchText.isEmpty {
                    SearchRecentCollectionsSection(state: viewModel.recentState)
                    SearchTopSearchSection()
                } else {
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(AppColors.darkBackground.ignoresSafeArea())
        .task {
            await viewModel.loadRecentCollectionsIfNeeded()
        }
    }
}

#Preview {
    SearchPageView(viewModel: AppContainer().makeSearchViewModel())
}
