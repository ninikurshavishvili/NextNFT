//
//  CollectionContainerView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionContainerView: View {
    let collection: NFTCollection

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CollectionProfileView(
                    imageURL: collection.imageURL,
                    name: collection.name
                )
                
                Spacer()
                
                Image(systemName: "arrow.forward")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding()
                    .background(AppColors.lightGrey.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack(alignment: .firstTextBaseline, spacing: 80) {
                CollectionInfoView(title: "Category", value: collection.category ?? "ART")
                CollectionInfoView(title: "Price", value: collection.id)
                
            }
            .padding()
            .padding(.horizontal)
            
            //COLLECTION LIST VIEW HERE
                CollectionListView(collectionSlug: collection.collection)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(AppColors.darkBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
        .padding()
    }
}

#Preview {
    // ✅ Provide mock data for preview
    let sampleCollection = NFTCollection(
        collection: "azuki",
        name: "Azuki",
        description: "A collection of 10,000 avatars for the metaverse.",
        imageURL: "https://example.com/image.png",
        bannerImageURL: "https://example.com/banner.png",
        owner: "0x123456789",
        category: "n",
        openseaURL: "https://opensea.io/collection/azuki",
        totalSupply: 10000,
        createdDate: "2025-10-25"
    )
    
    CollectionContainerView(collection: sampleCollection)
        .background(AppColors.darkBackground)
}


