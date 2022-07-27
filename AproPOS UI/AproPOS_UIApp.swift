//
//  AproPOS_UIApp.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

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
