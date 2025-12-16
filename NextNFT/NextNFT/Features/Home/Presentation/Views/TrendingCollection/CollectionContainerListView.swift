//
//  CollectionContainerListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.08.25.
//

import SwiftUI


struct CollectionContainerListView: View {
    let collections: [NFTCollection]
    
    var body: some View {
        VStack(spacing: 20) {
            // create one container per collection
            ForEach(collections.prefix(3)) { collection in
                CollectionContainerView(collection: collection)
            }

            Button {
                // handle View All action
            } label: {
                HStack {
                    Spacer()
                    Text("View All Collections")
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "arrow.right")
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background(AppColors.lightGrey.opacity(0.3))
                .cornerRadius(12)
            }
        }

    }
}


