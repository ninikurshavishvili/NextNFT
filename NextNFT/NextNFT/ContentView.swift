//
//  ContentView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI

@available(iOS 26.0, *)
struct ContentView: View {
    let container: AppContainer

    var body: some View {
        MainTabView(container: container)
            .environment(\.imageDownloadManager, container.imageDownloadManager)
    }
}




#Preview {
    if #available(iOS 26.0, *) {
        ContentView(container: AppContainer())
    } else {
        // Fallback on earlier versions
    }
}
