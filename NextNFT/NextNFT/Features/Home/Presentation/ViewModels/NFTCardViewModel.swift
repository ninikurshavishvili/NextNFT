//
//  NFTCardViewModel.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 05.02.26.
//

import SwiftUI
import Combine

@MainActor
class NFTCardViewModel: ObservableObject {
    
    @Published var backgroundColor: Color = AppColors.darkBackground
    @Published var isLoading = false
    
    private let imageURL: String?
    
    init(imageURL: String?) {
        self.imageURL = imageURL
        Task {
            await extractBackgroundColor()
        }
    }
    
    private func extractBackgroundColor() async {
        guard let imageURL,
              let url = URL(string: imageURL) else {
            backgroundColor = AppColors.darkBackground
            return
        }
        
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let uiImage = UIImage(data: data),
               let dominantColor = ImageColorAnalyzer.getDominantColor(from: uiImage) {
                
                let darker = ImageColorAnalyzer.darkenColor(dominantColor, by: 0.25)
                backgroundColor = darker
            } else {
                backgroundColor = AppColors.darkBackground
            }
            
        } catch {
            backgroundColor = AppColors.darkBackground
        }
        
        isLoading = false
    }
}

