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
    
    // Initially connect to Firebase at app startup
    init() {
        FirebaseApp.configure()
        // Perhaps load data here
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
            //ImplementOrderView()
            //ImplementBillingView()
            //ImplementMenuView()
            //ImplementInventoryView()
            //ImplementTableView()
        }
    }
}
