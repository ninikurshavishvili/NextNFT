//
//  CollectionContainerView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI
//TODO: here goes full container UI
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
            .padding()
            
            HStack(alignment: .firstTextBaseline, spacing: 80) {
                CollectionInfoView()
                
                CollectionInfoView()
            }
            .padding()
            
            CollectionListView()
                .padding()
        }
    }
}



#Preview {
    CollectionContainerView()
        .background(AppColors.darkBackground)
}
