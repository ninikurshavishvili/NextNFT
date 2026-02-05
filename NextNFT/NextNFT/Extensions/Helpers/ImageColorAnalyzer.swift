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
    
    static func getDominantColor(from image: UIImage) -> Color? {
        guard let inputImage = CIImage(image: image) else { return nil }
        
        // Set up the filter
        let filter = CIFilter.areaAverage()
        filter.inputImage = inputImage
        filter.extent = inputImage.extent
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // Create a small 1x1 image to get the average color
        let context = CIContext()
        var bitmap = [UInt8](repeating: 0, count: 4)
        let bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        context.render(outputImage,
                      toBitmap: &bitmap,
                      rowBytes: 4,
                      bounds: bounds,
                      format: .RGBA8,
                      colorSpace: CGColorSpaceCreateDeviceRGB())
        
        let red = CGFloat(bitmap[0]) / 255.0
        let green = CGFloat(bitmap[1]) / 255.0
        let blue = CGFloat(bitmap[2]) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
    
    static func darkenColor(_ color: Color, by percentage: CGFloat = 0.3) -> Color {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Darken each component
        red = max(0, red - percentage)
        green = max(0, green - percentage)
        blue = max(0, blue - percentage)
        
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}


