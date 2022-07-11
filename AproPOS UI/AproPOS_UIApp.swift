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
        // Perhaps load data here
    }
    
    var body: some Scene {
        WindowGroup {
            //LoginView()
            //MainView()
            //ImplementOrderView()
            //ImplementBillingView()
            //MenuView()
            //ImplementMenuView()
            //InventoryView()
            //ImplementInventoryView()
            TableView()
            //ImplementTableView()
            //ImplementStaffView()
        }
    }
}
