//
//  CustomNFTLisrView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 28.01.26.
//

import SwiftUI

struct CustomNFTLisrView: View {
    var body : some View {
        LazyHStack {
            ForEach(1...100, id: \.self) { i in
                CustomNFTCardView()
            }
        }
        .frame(width: 400, height: 200)
    }
}

#Preview {
    CustomNFTLisrView()
}
