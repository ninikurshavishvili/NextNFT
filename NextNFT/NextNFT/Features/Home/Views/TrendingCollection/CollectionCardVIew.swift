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
        ZStack(alignment: .topTrailing) {
            // Check if imageURL exists and is not empty/null
            if let imageURLString = nft.imageURL,
               !imageURLString.isEmpty,
               let url = URL(string: imageURLString) {
                
                // ✅ Image exists - show it
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        loadingView
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(16)
                    case .failure:
                        placeholderView
                    @unknown default:
                        placeholderView
                    }
                }
            } else {
                // ❌ No image - show placeholder
                placeholderView
            }

            // Plus button
            Button(action: {}) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(8)

            // "Place a bid" text
            VStack {
                Spacer()
                HStack {
                    Text("Place a bid")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(.ultraThinMaterial))
                    Spacer()
                }
                .padding(8)
            }
        }
        .frame(width: 120, height: 120)
        .padding()
    }
    
    var loadingView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.2))
            ProgressView()
        }
        .frame(width: 120, height: 120)
    }
    
    var placeholderView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.3))
            VStack {
                Image(systemName: "photo")
                    .font(.system(size: 30))
                    .foregroundColor(.white.opacity(0.7))
                Text("No Image")
                    .font(.system(size: 10))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(width: 120, height: 120)
    }
}


