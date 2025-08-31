//
//  NextNFTApp.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct NextNFTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var nFTViewModel = NFTViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(nFTViewModel)   // inject VM if ContentView needs it
                .onAppear {
                    nFTViewModel.fetchNFTs()       // ✅ call on the instance
                }
        }
    }
}

