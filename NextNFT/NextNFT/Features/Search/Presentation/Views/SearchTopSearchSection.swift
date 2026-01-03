//
//  SearchTopSearchSection.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct SearchTopSearchSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            sectionHeader("Top Search")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(MockData.topCollections) { collection in
                        NFTCollectionCardView(collection: collection)
                    }
                }
            }
        }
    }
}

