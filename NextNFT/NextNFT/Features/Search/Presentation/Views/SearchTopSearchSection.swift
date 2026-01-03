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
                    ForEach(0..<5) { _ in
                        Image("image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 5)
                    }
                }
            }
        }
    }
}

