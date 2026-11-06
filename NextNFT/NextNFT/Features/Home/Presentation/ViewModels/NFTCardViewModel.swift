//
//  NFTCardViewModel.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 05.02.26.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class NFTCardViewModel {

    private(set) var backgroundColor: Color = AppColors.darkBackground
    private(set) var isLoading = false

    private let imageURL: String?
    private var hasLoaded = false

    init(imageURL: String?) {
        self.imageURL = imageURL
    }

    /// Called from the card's `.task`, not `init`: SwiftUI may create a
    /// view's initial `@State` value more than once.
    func loadBackgroundColor() async {
        guard !hasLoaded else { return }

        guard let imageURL,
              let url = URL(string: imageURL) else {
            backgroundColor = AppColors.darkBackground
            hasLoaded = true
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let uiImage = UIImage(data: data),
               let dominantColor = ImageColorAnalyzer.getDominantColor(from: uiImage) {

                let darker = ImageColorAnalyzer.darkenColor(dominantColor, by: 0.25)
                backgroundColor = darker
            } else {
                backgroundColor = AppColors.darkBackground
            }
            hasLoaded = true

        } catch where error.isCancellation {
            // Try again the next time the card appears
        } catch {
            backgroundColor = AppColors.darkBackground
            hasLoaded = true
        }
    }
}
