//
//  HomeHeaderView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 12.08.25.
//

import SwiftUI


struct HomeHeaderView: View {
    var body: some View {
        HStack {
            (
                Text("Next")
                    .foregroundStyle(.white)
                +
                Text("NFT")
                    .foregroundStyle(.mainPurple)
            )
            .font(.system(.title2, design: .serif, weight: .bold))
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(AppColors.darkBackground.opacity(0.9))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .background(Color.black) // matches screenshot background
    }
}



#Preview {
    HomeHeaderView()
}
