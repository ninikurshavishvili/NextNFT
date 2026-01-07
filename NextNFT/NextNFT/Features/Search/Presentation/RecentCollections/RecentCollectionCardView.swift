//
//  RecentCollectionCardView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 07.01.26.
//

import SwiftUI

struct RecentCollectionCardView: View {

    let collection: NFTCollection

    var body: some View {
        ZStack(alignment: .bottom) {

            backgroundImage

            overlayContent
        }
        .frame(width: 260, height: 340)
        .cornerRadius(28)
        .shadow(radius: 8)
    }
}

private extension RecentCollectionCardView {

    var backgroundImage: some View {
        AsyncImage(url: URL(string: collection.imageURL ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .clipped()
    }
}

private extension RecentCollectionCardView {

    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {

            headerInfo

            Spacer()

            actionButtons
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.black.opacity(0.6), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
}

private extension RecentCollectionCardView {

    var actionButtons: some View {
        HStack(spacing: 12) {

            capsuleButton(
                title: "Activity",
                systemImage: "waveform.path.ecg"
            )

            capsuleButton(
                title: "Collection",
                systemImage: "square.grid.2x2",
                filled: true
            )
        }
    }

    func capsuleButton(
        title: String,
        systemImage: String,
        filled: Bool = false
    ) -> some View {
        HStack {
            Image(systemName: systemImage)
            Text(title)
        }
        .font(.subheadline)
        .foregroundColor(filled ? .black : .white)
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(
            filled ? Color.white : Color.white.opacity(0.25)
        )
        .clipShape(Capsule())
    }
}


private extension RecentCollectionCardView {

    var headerInfo: some View {
        VStack(alignment: .leading, spacing: 4) {

            Text(collection.name)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)

            if let price = collection.totalSupply {
                Text("Floor price \(price, specifier: "%.3f") ETH")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}
