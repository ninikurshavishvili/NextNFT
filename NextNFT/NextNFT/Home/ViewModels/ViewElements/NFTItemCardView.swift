//
//  NFTItemCardView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI

struct NFTItemCardView: View {
    var body: some View {
        
        ZStack {
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 210)
                    .cornerRadius(16)
                    .padding()
            VStack{
                Button(action: {
                    //fqf
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.primary.opacity(0.4))
                        .cornerRadius(16)
                    
                }
            }
        }
    }
}


#Preview {
    NFTItemCardView()
}
