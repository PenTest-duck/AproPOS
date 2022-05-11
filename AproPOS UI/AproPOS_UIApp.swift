//
//  AproPOS_UIApp.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI
import Firebase

@main
struct AproPOS_UIApp: App {
    
    // Initially connect to Firebase at app startup
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
