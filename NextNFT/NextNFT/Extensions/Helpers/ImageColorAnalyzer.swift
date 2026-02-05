//
//  ImageColorAnalyzer.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 05.02.26.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageColorAnalyzer {
    
    static func getDomainColor(from image: UIImage) -> Color? {
        guard let inputImage = CIImage(image: image) else {return nil}
        
        // Set up the filter
               let filter = CIFilter.areaAverage()
               filter.inputImage = inputImage
               filter.extent = inputImage.extent
        
    }
}


