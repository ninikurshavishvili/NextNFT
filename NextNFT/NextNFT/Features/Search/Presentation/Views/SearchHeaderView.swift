//
//  Untitled.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import SwiftUI

struct SearchHeaderView: View {
    let balance: String

    var body: some View {
        HStack {
            VStack {
                Text("Explore ")
                    .foregroundColor(.white)
                + Text("NFT ")
                    .foregroundColor(.mainPurple)
                + Text("Collections ")
                    .foregroundColor(.white)
                + Text("or Creators")
                    .foregroundColor(.white)
            }
            .font(.system(.title2, design: .serif, weight: .bold))


            Spacer()

            HStack() {
                Image("etherium")
                    .resizable()
                    .frame(width: 16, height: 26)
                    .foregroundStyle(AppColors.darkBackground)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedCorner(radius: 16))
                Text(balance)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }

            .background(Color(.systemGray5).opacity(0.15))
            .cornerRadius(16)
        }
        .font(.title2.bold())
    }
}

#Preview {
    SearchHeaderView(balance: "43.22")
        .background(AppColors.darkBackground)
}
