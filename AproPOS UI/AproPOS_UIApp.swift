//
//  AproPOS_UIApp.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//
///This file is for the opening view for when the app is built and run
///views can be changed to access them faster and  test them

import SwiftUI
import FirebaseCore

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
