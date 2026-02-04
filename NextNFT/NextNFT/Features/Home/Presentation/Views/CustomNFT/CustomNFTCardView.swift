//
//  CustomNFT.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 27.01.26.
//

import SwiftUI

struct CustomNFTCardView: View {

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Image
            Image("image")
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .cornerRadius(25)

            // MARK: - Content
            VStack(alignment: .leading, spacing: 12) {

                Text("CryptoPunks V1")
                    .font(.headline)
                    .foregroundStyle(Color(.systemGray2))

                Text("""
Released on June 9, 2017 by Larva Labs. This is the original ERC-20 token now tradable via a modern ERC-721 wrapper.
""")
                    .font(.footnote.bold())
                    .foregroundStyle(.lightGrey)
                    .lineLimit(3)

                Spacer(minLength: 60)

                
                HStack {

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Volume")
                            .font(.caption.bold())
                            .foregroundStyle(.darkGrey)

                        Text("45.5K POL")
                            .font(.headline)
                            .foregroundStyle(Color(.systemGray2))
                    }

                    Spacer()

                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 1, height: 32)

                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Floor")
                            .font(.caption.bold())
                            .foregroundStyle(.darkGrey)

                        Text("--")
                            .font(.headline)
                            .foregroundStyle(Color(.systemGray2))
                    }
                }
            }
            .padding(16)
            .background(AppColors.mainPurple)
        }
        .frame(width: 300, height: 500)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 6)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CustomNFTCardView()
    }
}
