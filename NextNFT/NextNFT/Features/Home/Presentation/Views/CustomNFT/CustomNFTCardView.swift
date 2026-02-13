//
//  CustomNFT.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 27.01.26.
//

import SwiftUI

struct CustomNFTCardView: View {
    
    let nft: NFT
    @StateObject private var viewModel: NFTCardViewModel
    
    init(nft: NFT) {
        self.nft = nft
        _viewModel = StateObject(
            wrappedValue: NFTCardViewModel(
                imageURL: nft.displayImageURL ?? nft.imageURL
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Image
            AsyncImage(url: URL(string: nft.displayImageURL ?? nft.imageURL ?? "")) { phase in
                
                switch phase {
                    
                case .empty:
                    ProgressView()
                        .frame(height: 240)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipped()
                    
                case .failure:
                    Color.gray
                        .frame(height: 240)
                    
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
            
            // MARK: - Content
            VStack(alignment: .leading, spacing: 12) {
                
                Text(nft.name ?? "Unknown NFT")
                    .font(.headline)
                    .foregroundStyle(Color(.systemGray2))
                
                Text(nft.description ?? "No description available.")
                    .font(.footnote.bold())
                    .foregroundStyle(AppColors.lightGrey)
                    .lineLimit(3)
                
                Spacer(minLength: 60)
            }
            .padding(16)
        }
        .frame(width: 300, height: 500)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.backgroundColor)
    }
}


//#Preview {
//    ZStack {
//        CustomNFTCardView()
//    }
//}
