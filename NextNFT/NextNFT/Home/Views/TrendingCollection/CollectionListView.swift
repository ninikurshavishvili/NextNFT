//
//  CollectionListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionListView: View {
    @StateObject private var viewModel = NFTViewModel()
    var collectionSlug: String = "doodles-official"

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
            viewModel.fetchNFTs(for: collectionSlug)
        }
    }
}

#Preview {
    CollectionListView()
}
