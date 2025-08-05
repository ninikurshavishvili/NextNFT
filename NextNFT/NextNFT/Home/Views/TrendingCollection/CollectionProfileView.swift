//
//  CollectionProfileView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionProfileView : View {
    var body: some View {
        HStack {
            Image("image")
                .resizable()
                .frame(width: 37, height: 37)
                .cornerRadius(12)
            
            Text("DX Terminal")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
            Image("verified")
                .resizable()
                .frame(width: 15, height: 15)

        }
    }
}
//haaa

#Preview {
    CollectionProfileView()
        .background(Color.black)
}
