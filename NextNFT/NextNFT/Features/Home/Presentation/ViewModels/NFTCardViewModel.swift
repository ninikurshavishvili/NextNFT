//
//  NFTCardViewModel.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 05.02.26.
//

import SwiftUI
import Combine

class NFTCardViewModel: ObservableObject {
    @Published var backgroundColor: Color = AppColors.darkBackground
    @Published var isLoading = false
    
    private let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        extractBackgroundColor()
    }
    
    private func extractBackgroundColor() {
        isLoading = true
        
        // In a real app, you might fetch from network
        // For now, we'll use local images
        guard let image = UIImage(named: imageName) else {
            backgroundColor = AppColors.darkBackground
            isLoading = false
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let dominantColor = ImageColorAnalyzer.getDominantColor(from: image) {
                let darkerColor = ImageColorAnalyzer.darkenColor(dominantColor, by: 0.25) // 25% darker
                
                DispatchQueue.main.async {
                    self.backgroundColor = darkerColor
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.backgroundColor = AppColors.darkBackground
                    self.isLoading = false
                }
            }
        }
    }
}
