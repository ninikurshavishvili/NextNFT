//
//  CollectionListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionListView: View {
    @StateObject private var viewModel = NFTViewModel()
    var collectionSlug: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.nfts, id: \.identifier) { nft in
                    CollectionCardView(nft: nft)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 2)
        .onAppear {
            // Fetch NFTs only once for this specific collection
            if viewModel.nfts.isEmpty {
                viewModel.fetchNFTs(for: collectionSlug)
            }
        }
    }
}

#Preview {
    CollectionListView(collectionSlug: "azuki")
}
