//
//  CollectionInfoView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI


struct CollectionInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppColors.lightGrey)
            
            HStack {
                Text(value)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    CollectionInfoView(title: "Category", value: "Art")
        .background(Color.black)
}
