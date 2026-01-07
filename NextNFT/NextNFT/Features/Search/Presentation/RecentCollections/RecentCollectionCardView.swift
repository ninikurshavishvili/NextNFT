//
//  RecentCollectionCardView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 07.01.26.
//

struct RecentCollectionCardView: View {

    let collection: NFTCollection

    var body: some View {
        ZStack(alignment: .bottom) {

            backgroundImage

            overlayContent
        }
        .frame(width: 260, height: 340)
        .cornerRadius(28)
        .shadow(radius: 8)
    }
}
