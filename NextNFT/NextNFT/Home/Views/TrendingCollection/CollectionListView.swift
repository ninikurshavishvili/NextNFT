//
//  CollectionListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionListView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<10) { index in
                    CollectionCardView()
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.black)
    }
}

#Preview {
    CollectionListView()
}
