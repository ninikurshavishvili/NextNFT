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
                                .foregroundStyle(AppColors.lightGrey)
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
                        Text("Price")
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.lightGrey)
                            .fontDesign(.rounded)
                        
                        HStack {
                            Image(systemName: "")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.green)
                            
                            Text("0.332 ETH")
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                        }
                        //sdkjvbakd
                        
                    }
                }
            }
            .padding(10)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.ultraThinMaterial.opacity(0.7))
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.black.opacity(0.7))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(12)
            .frame(width: 210)
            .padding(.bottom, 20)
            .frame(maxHeight: .infinity, alignment: .bottom)



        }
        .frame(width: 160, height: 210)

    }
}


#Preview {
    NFTItemCardView()
}
