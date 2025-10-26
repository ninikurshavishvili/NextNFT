//
//  Untitled.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.08.25.
//

import SwiftUI

struct TrendingView: View {
    let collections: [CollectionModel]

    @State private var selectedTab = "Collections"
    @State private var selectedIconIndex = 3
    @State private var selectedDay = "1D"
    
    let tabs = ["Collections", "Marketplaces"]
    let icons = ["square.stack.3d.up", "dollarsign.circle", "leaf.fill", "flame.fill", "bitcoinsign.circle"]
    let days = ["1H", "4H", "1D", "7D", "30D"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Trending")
                    .font(.system(.title, design: .serif, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.leading)

                // Tabs + icons + days remain unchanged...
                
                // ✅ Show collections that HomeView passed in
                if collections.isEmpty {
                    Text("No collections yet")
                        .foregroundStyle(.gray)
                        .padding()
                } else {
                    CollectionContainerListView(collections: collections)
                }
            }

        }
    }
}

#Preview {
    TrendingView(collections: [])
        .background(Color.black)
}

