//
//  NFTCollectionCardView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct NFTCollectionCardView: View {
    let collection: NFTCollection

    var body: some View {
        ZStack(alignment: .bottom) {

            RoundedRectangle(cornerRadius: 22)
                .fill(collection.gradient)

            VStack(alignment: .leading, spacing: 6) {
                Text(collection.name)
                    .font(.headline)
                    .foregroundColor(.white)

                Text("Floor price \(collection.floorPrice) ETH")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))

                HStack {
                    ActionButton(title: "Activity", icon: "waveform.path.ecg")
                    ActionButton(title: "Collection", icon: "square.grid.2x2")
                }
            }
            .padding()
        }
        .frame(width: 260, height: 320)
    }
}

