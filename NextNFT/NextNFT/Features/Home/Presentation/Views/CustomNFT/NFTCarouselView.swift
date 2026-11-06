//
//  CustomNFTLisrView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 28.01.26.
//

import SwiftUI

struct NFTCarouselView: View {
    
    let viewModel: NFTCarouselViewModel
    var collectionSlug: String = "cryptopunks"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Header
            HStack {
                Text("Create a custom ")
                    .foregroundColor(.white)
                + Text("NFT")
                    .foregroundColor(.mainPurple)
                + Text(" Marketplace for your community")
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    // action later
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .font(.system(.title2, design: .serif, weight: .bold))
            .padding(.horizontal)
            
            switch viewModel.state {
            case .idle, .loading:
                HStack {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.2)
                        .padding(.vertical, 40)
                    Spacer()
                }
            case .failed(let message):
                HStack {
                    Spacer()
                    Text("Failed to load NFTs: \(message)")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                }
            case .loaded(let content):
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(content.nfts) { nft in
                            // Pass both NFT and Collection to the card
                            CustomNFTCardView(
                                nft: nft,
                                collection: content.collection
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
            case .empty:
                EmptyView()
            }
        }
        .task {
            await viewModel.loadIfNeeded(for: collectionSlug)
        }
    }
}


#Preview {
    NFTCarouselView(viewModel: AppContainer().makeNFTCarouselViewModel())
        .background(.darkBackground)
}
