//
//  NFTItemCardView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import SwiftUI

struct NFTItemCardView: View {
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
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
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.primary.opacity(0.4))
                        .cornerRadius(12)
                    
                }
                .padding(6)
            }
            .padding()

            VStack {
                Text("Pudgy Penguin #1232")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                
                VStack {
                    HStack {
                        
                    }
                }
            }
            .background(Color.primary.opacity(0.4))
            .padding()

        }
    }
}


#Preview {
    NFTItemCardView()
}
