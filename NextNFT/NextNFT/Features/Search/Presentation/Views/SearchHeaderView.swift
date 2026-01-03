//
//  Untitled.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct SearchHeaderView: View {
    let balance: String

    var body: some View {
        HStack {
            Text("Explore ")
                .foregroundColor(.white)
            + Text("NFT")
                .foregroundColor(.blue)
            + Text(" Collections\nor Creators")
                .foregroundColor(.white)

            Spacer()

            HStack(spacing: 8) {
                Image(systemName: "diamond.fill")
                Text(balance)
                    .fontWeight(.semibold)
            }
            .padding(10)
            .background(Color(.systemGray5).opacity(0.15))
            .cornerRadius(14)
        }
        .font(.title2.bold())
    }
}
