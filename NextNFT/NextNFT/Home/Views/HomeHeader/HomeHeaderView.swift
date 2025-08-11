//
//  HomeHeaderView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 12.08.25.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        
        Text("Next")
            .foregroundStyle(.darkBackground)
            .font(.system(.title2, design: .serif, weight: .bold))

        +
        Text("NFT")
            .foregroundStyle(.mainPurple)
            .font(.system(.title2, design: .serif, weight: .bold))

    }

}


#Preview {
    HomeHeaderView()
}
