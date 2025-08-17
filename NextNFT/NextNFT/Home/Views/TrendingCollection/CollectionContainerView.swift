//
//  CollectionContainerView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CollectionProfileView()
                
                Spacer()
                
                Image(systemName: "arrow.forward")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding()
                    .background(AppColors.lightGrey.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack(alignment: .firstTextBaseline, spacing: 80) {
                CollectionInfoView()
                CollectionInfoView()
            }
            .padding(.horizontal)
            
            CollectionListView()
                .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(AppColors.darkBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
        .padding()
    }
}




#Preview {
    CollectionContainerView()
        .background(AppColors.darkBackground)
}
