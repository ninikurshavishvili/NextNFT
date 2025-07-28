//
//  CollectionCardVIew.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 22.07.25.
//

import SwiftUI

struct CollectionCardView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(16)

            Button(action: {
                // action 
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
                    .background(
                        .ultraThinMaterial
                    )
                    .clipShape(Circle())
            }
            .padding(8)

            VStack {
                Spacer()
                HStack {
                    Text("Place a bid")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                    Spacer()
                }
                .padding(8)
            }
        }
        .frame(width: 108, height: 108)
    }
}

#Preview {
    CollectionCardView()
        .preferredColorScheme(.dark)
}

