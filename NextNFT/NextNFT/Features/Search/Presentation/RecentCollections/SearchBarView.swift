//
//  SearchBarView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 07.01.26.
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
                        .foregroundStyle(AppColors.lightGrey.opacity(0.3))
                }
            }

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
        }
        .padding()
        .background(AppColors.lightGrey)
        .cornerRadius(16)
    }
}
