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
            HStack() {
                ForEach(0..<10) { index in
                    CollectionCardView()
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    CollectionListView()
}
