//
//  SearchRecentCollectionsSection.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI
struct SearchRecentCollectionsSection: View {

    let state: ViewState<[NFTCollection]>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader

            switch state {
            case .idle, .loading:
                cardsRow {
                    // Show skeleton loading cards
                    ForEach(0..<5) { _ in
                        SkeletonCollectionCardView()
                    }
                }
            case .loaded(let collections):
                cardsRow {
                    ForEach(collections) { collection in
                        RecentCollectionCardView(collection: collection)
                    }
                }
            case .empty:
                message("No recent collections yet")
            case .failed(let errorMessage):
                message(errorMessage)
            }
        }
    }

    private func cardsRow(@ViewBuilder content: () -> some View) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                content()
            }
            .padding(.horizontal)
        }
    }

    private func message(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(.gray)
            .padding(.horizontal)
    }

    
    
    private var sectionHeader: some View {
        HStack {
            Text("Recent Collection")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            Button("See all") {
                // navigation later
            }
            .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            // Loading state
            SearchRecentCollectionsSection(state: .loading)

            // Loaded state
            SearchRecentCollectionsSection(state: .loaded(NFTCollection.previewSamples))
        }
    }
}
