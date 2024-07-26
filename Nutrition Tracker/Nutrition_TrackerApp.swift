//
//  Nutrition_TrackerApp.swift
//  Nutrition Tracker
//
//  Created by Jared Ryan on 7/18/24.
//

import SwiftUI

@main
struct Nutrition_TrackerApp: App {
    @StateObject private var foodLogStore = FoodLogStore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Scan", systemImage: "barcode.viewfinder")
                    }
                FoodLogView()
                    .tabItem {
                        Label("Log", systemImage: "list.bullet")
                    }
            }
            .environmentObject(foodLogStore)
        }
    }
}
