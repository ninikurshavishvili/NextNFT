//
//  CollectionInfoView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionInfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Day")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.lightGrey)
            
            HStack {
                Text("126.2")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                Text("ETH")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.lightGrey)
            }
            Text("+71.2%")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.green)
            
        }
    }
}


#Preview {
    CollectionInfoView()
        .background(Color.black)
}
