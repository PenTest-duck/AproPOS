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
    
    // Initially configures a default Firebase App
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup { // container for view hierarchy
            LoginView() // first view app opens to
        }
    }
}
