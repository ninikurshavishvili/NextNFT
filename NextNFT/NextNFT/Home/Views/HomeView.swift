//
//  HomeView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack {
            ScrollView {
                HomeHeaderView()
                
                NFTItemListView()
                
                TrendingView()
                
                CollectionContainerListView()
                
            }
        }
        .background(AppColors.darkBackground)
    }
}

#Preview {
    HomeView()
}
