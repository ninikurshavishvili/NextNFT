//
//  CustomNFT.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 27.01.26.
//

import SwiftUI

struct CustomNFTCardView: View {
    let imageName: String
    @StateObject private var viewModel: NFTCardViewModel
    @State private var image: UIImage?
    
    init(imageName: String) {
        self.imageName = imageName
        _viewModel = StateObject(wrappedValue: NFTCardViewModel(imageName: imageName))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
            
            // MARK: - Content
            VStack(alignment: .leading, spacing: 12) {
                Text("CryptoPunks V1")
                    .font(.headline)
                    .foregroundStyle(Color(.systemGray2))
                
                Text("""
Released on June 9, 2017 by Larva Labs. This is the original ERC-20 token now tradable via a modern ERC-721 wrapper.
""")
                    .font(.footnote.bold())
                    .foregroundStyle(AppColors.lightGrey)
                    .lineLimit(3)
                
                Spacer(minLength: 60)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Volume")
                            .font(.caption.bold())
                            .foregroundStyle(AppColors.darkGrey)
                        
                        Text("45.5K POL")
                            .font(.headline)
                            .foregroundStyle(Color(.systemGray2))
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 1, height: 32)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Floor")
                            .font(.caption.bold())
                            .foregroundStyle(AppColors.darkGrey)
                        
                        Text("--")
                            .font(.headline)
                            .foregroundStyle(Color(.systemGray2))
                    }
                }
            }
            .padding(16)
        }
        .frame(width: 300, height: 500)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.backgroundColor)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                }
            }
        )
        .animation(.easeInOut(duration: 0.3), value: viewModel.backgroundColor)
    }
}

#Preview {
    ZStack {
        CustomNFTCardView(imageName: "image")
    }
}
