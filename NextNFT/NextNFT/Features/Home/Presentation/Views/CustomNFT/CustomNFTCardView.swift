//
//  CustomNFT.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 27.01.26.
//

import SwiftUI

struct CustomNFTCardView: View {
    
    var body: some View {
        VStack {
            Image("image")
                .resizable()
                .scaledToFit()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

            Text("Custom NFT")
                .font(.title)
        }
    }
}

#Preview {
    CustomNFTCardView()
}
