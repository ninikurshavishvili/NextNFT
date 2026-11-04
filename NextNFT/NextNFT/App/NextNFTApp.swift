//
//  NextNFTApp.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI
import Firebase
import OSLog


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    configureFirebase()

    return true
  }

  /// GoogleService-Info.plist is committed without a real API key, so the key
  /// comes from Config.xcconfig (API_KEY) via Info.plist (FIREBASE_API_KEY).
  private func configureFirebase() {
    guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
          let options = FirebaseOptions(contentsOfFile: path) else {
      Logger.app.error("GoogleService-Info.plist is missing; Firebase is not configured.")
      return
    }

    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "FIREBASE_API_KEY") as? String,
          !apiKey.isEmpty else {
      Logger.app.error("API_KEY is missing from Config.xcconfig; Firebase is not configured.")
      return
    }

    options.apiKey = apiKey
    FirebaseApp.configure(options: options)
  }
}

@available(iOS 26.0, *)
@main
struct NextNFTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    /// Built once for the app's lifetime.
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}


