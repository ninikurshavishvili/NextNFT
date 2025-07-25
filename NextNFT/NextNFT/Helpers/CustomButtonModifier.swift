//
//  CustomButtonModifier.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 24.07.25.
//

import SwiftUI

struct HomePageButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color(red: 36/255, green: 38/255, blue: 40/255)) // #242628
            .cornerRadius(16)
            .padding(.horizontal)
    }
}

extension View {
    func homePageButtonStyle() -> some View {
        self.modifier(HomePageButtonStyle())
    }
}
//wtf
