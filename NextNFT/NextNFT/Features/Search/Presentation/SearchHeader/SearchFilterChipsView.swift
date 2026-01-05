//
//  SearchFilterChipsView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct SearchFilterChipsView: View {
    let selected: SearchType
    let onSelect: (SearchType) -> Void

    var body: some View {
        HStack(spacing: 12) {
            chip("Recent", .collections)
            chip("Trending", .nfts)
            chip("Top Art", .collections)
        }
            .padding(4)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
    }

    func chip(_ title: String, _ type: SearchType) -> some View {
        Button {
            onSelect(type)
        } label: {
            Text(title)
                .fontWeight(.medium)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    selected == type ? .mainPurple : Color(.systemGray5).opacity(0.15)
                )
                .foregroundColor(.white)
                .cornerRadius(14)
        }
    }
}

