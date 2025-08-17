//
//  CollectionContainerListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.08.25.
//

import SwiftUI


struct CollectionContainerListView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Vertical list of 3 CollectionContainerViews
            ForEach(0..<3, id: \.self) { _ in
                CollectionContainerView()
            }
            
            // Button below
            Button(action: {
                // Handle action
            }) {
                HStack {
                    Spacer()
                    Text("View All Collections")
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background(AppColors.lightGrey.opacity(0.3))
                .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }
}

