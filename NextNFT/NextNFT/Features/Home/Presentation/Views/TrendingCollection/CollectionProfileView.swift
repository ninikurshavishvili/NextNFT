//
//  CollectionProfileView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionProfileView: View {
    let imageURL: String?
    let name: String

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 37, height: 37)
            .cornerRadius(12)
            
            Text(name)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
            
            Image("verified")
                .resizable()
                .frame(width: 15, height: 15)
        }
    }
}


#Preview {
    CollectionProfileView(imageURL: "Image", name: "na")
        .background(Color.black)
}
