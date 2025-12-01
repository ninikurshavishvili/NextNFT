//
//  CollectionCardVIew.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 22.07.25.
//

import SwiftUI

struct CollectionCardView: View {
    let nft: NFTModel
    
    var body: some View {
        VStack {
            // Use nft.imageURL which is the correct property from your model
            if let imageUrlString = nft.imageURL,
               let url = URL(string: imageUrlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                // Fallback if no image URL
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.white)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text(nft.name ?? "Unnamed NFT")
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(.white)
        }
    }
}


