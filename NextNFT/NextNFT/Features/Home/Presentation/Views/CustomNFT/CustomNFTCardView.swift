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
                                        2017 by Larva Labs. This is the original ERC-20 token now tradable via a modern ERC-721 wrapper.2017 by Larva Labs. This is the original ERC-20 token now tradable via a modern ERC-721 wrapper.
                    """)
                .font(.footnote .bold())
                .foregroundStyle(.lightGrey)
                .padding(.horizontal)
                .lineLimit(3)
                
                Spacer()
                
                HStack {
                    VStack(alignment : .leading) {
                        Text("Volume")
                            .padding(.horizontal)
                            .font(Font.caption.bold())
                            .foregroundStyle(.darkGrey)
                        
                        Text("45.5K POL")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundStyle(Color(.systemGray2))
                        
                    }
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 1, height: 32)
                    
                    VStack(alignment : .leading) {
                        Text("floor")
                            .padding(.horizontal)
                            .font(Font.caption.bold())
                            .foregroundStyle(.darkGrey)
                        
                        Text("--")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundStyle(Color(.systemGray2))
                        
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 6)
        .padding()
    }
}

#Preview {
    CustomNFTCardView()
}
