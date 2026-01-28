//
//  CustomNFTLisrView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 28.01.26.
//

import SwiftUI

struct CustomNFTListView: View {
    var body : some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(1...100, id: \.self) {_ in 
                    CustomNFTCardView()
                }
            }
        }
        .frame(width: 400, height: 200)
    }
}

#Preview {
    CustomNFTListView()
}
