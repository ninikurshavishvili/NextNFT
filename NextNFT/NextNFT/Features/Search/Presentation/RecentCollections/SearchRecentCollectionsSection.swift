//
//  SearchRecentCollectionsSection.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI
//MARK: - fix Recent Collection Section
struct SearchRecentCollectionsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            sectionHeader("Recent Collection")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Text("NEED TO FIX THIS PART")
//                    ForEach() {
//                    }
                }
            }
        }
    }
}

#Preview {
    SearchRecentCollectionsSection()
}
