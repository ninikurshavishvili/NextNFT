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
    
    @StateObject private var collectionViewModel = CollectionsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collectionViewModel)   // inject VM if ContentView needs it
                .onAppear {
                    print(collectionViewModel.collections)
                }
        }
    }
}

