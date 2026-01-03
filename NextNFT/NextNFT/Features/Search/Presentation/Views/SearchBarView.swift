//
//  SearchBarView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let onClear: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search NFT or artist name...", text: $text)
                .foregroundColor(.white)

            if !text.isEmpty {
                Button(action: onClear) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(.systemGray5).opacity(0.15))
        .cornerRadius(16)
    }
}
