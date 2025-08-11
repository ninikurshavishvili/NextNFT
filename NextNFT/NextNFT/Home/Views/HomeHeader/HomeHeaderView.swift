//
//  HomeHeaderView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 12.08.25.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
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
            
            HStack(alignment: .center) {
                Text("List of top seller\nand creator")
                    .foregroundStyle(.white)
                    .font(.system(.title, design: .serif, weight: .bold))
                    .lineSpacing(4)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 88)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(AppColors.darkBackground, lineWidth: 2)
                        )
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .background(Color.black.ignoresSafeArea())
    }
}




#Preview {
    HomeHeaderView()
}
