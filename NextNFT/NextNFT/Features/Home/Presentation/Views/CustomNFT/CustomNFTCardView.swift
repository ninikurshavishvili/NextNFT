//
//  CustomNFT.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 27.01.26.
//

import SwiftUI

struct CustomNFTCardView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("image")
                .resizable()
                .scaledToFit()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

            VStack(alignment: .leading) {
                Text("CryptoPunks V1")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundStyle(Color(.systemGray2))
                Text("""
                    Released on June 9, 2017 by Larva Labs. This is the original ERC-20 token now tradable via a modern ERC-721 wrapper.
                    """)
                .font(.footnote .bold())
                .foregroundStyle(.lightGrey)
                .padding(.horizontal)
                
            }
        }
    }
}

#Preview {
    CustomNFTCardView()
}
