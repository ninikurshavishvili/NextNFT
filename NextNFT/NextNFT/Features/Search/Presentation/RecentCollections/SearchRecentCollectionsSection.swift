//
//  SearchRecentCollectionsSection.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI
//MARK: - fix Recent Collection Section
struct SearchRecentCollectionsSection: View {

    let collections: [NFTCollection]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            sectionHeader

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(collections) { collection in
                        RecentCollectionCardView(collection: collection)
                    }
                }
                .padding(.horizontal)
            }
        }
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

#Preview {
    SearchRecentCollectionsSection(
        collections: [
            NFTCollection(
                collection: "impostors-genesis",
                name: "Impostors Genesis",
                description: nil,
                imageURL: "https://picsum.photos/400",
                bannerImageURL: nil,
                owner: nil,
                category: nil,
                openseaURL: nil,
                totalSupply: nil,
                createdDate: nil
            )
        ]
    )
}

