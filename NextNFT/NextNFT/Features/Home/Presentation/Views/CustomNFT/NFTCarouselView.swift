//
//  CustomNFTLisrView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 28.01.26.
//

import SwiftUI


struct NFTCarouselView: View {
    @ObservedObject var viewModel: NFTCarouselViewModel
    let collectionSlug: String
    
    init(viewModel: NFTCarouselViewModel = NFTCarouselViewModel(),
         collectionSlug: String = "cryptopunks") {
        self.viewModel = viewModel
        self.collectionSlug = collectionSlug
    }
    
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
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.2)
                        .padding(.vertical, 40)
                    Spacer()
                }
            } else if let error = viewModel.errorMessage {
                HStack {
                    Spacer()
                    Text("Failed to load NFTs: \(error)")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {

                        // FIXME: 
//                        ForEach(viewModel.nfts) {
//                            
//                            
//                            
//                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
            }
        }
        .task {
            if viewModel.nfts.isEmpty {
                await viewModel.loadNFTs(for: collectionSlug)
            }
        }
    }
}


#Preview {
    NFTCarouselView()
        .background(.darkBackground)
}
