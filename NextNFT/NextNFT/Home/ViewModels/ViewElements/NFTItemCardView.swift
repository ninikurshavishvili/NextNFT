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
                .padding()

            VStack(alignment: .leading, spacing: 4) {
                Text("Pudgy Penguin #1232")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                
                HStack(alignment: .firstTextBaseline, spacing: 20) {
                    VStack {
                        VStack {
                            Text("Minting")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .fontDesign(.rounded)
                            
                            HStack {
                                Image(systemName: "inset.filled.circle")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.green)
                                
                                Text("Now")
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                    }

                    VStack {
                        Text("Minting")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .fontDesign(.rounded)
                        
                        HStack {
                            Image(systemName: "inset.filled.circle")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.green)
                            
                            Text("Now")
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                        }
                        //sdkjvbakd
                        
                    }
                }
            }
            .padding(6)
            .background(Color.primary.opacity(0.4))
//ooopswefwefweg
        }
    }
}


#Preview {
    NFTItemCardView()
}
