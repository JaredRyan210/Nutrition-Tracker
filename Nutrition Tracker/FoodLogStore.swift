//
//  FoodLogStore.swift
//  Nutrition Tracker
//
//  Created by Jared Ryan on 7/18/24.
//

import Foundation

struct FoodLog: Identifiable, Codable {
    let id: UUID
    let name: String
    let brand: String
    let calories: Double
    let date: Date
}

class FoodLogStore: ObservableObject {
    @Published var foodLogs: [FoodLog] = []
    
    func addFoodLog(name: String, brand: String, calories: Double) {
        let newLog = FoodLog(id: UUID(), name: name, brand: brand, calories: calories, date: Date())
        foodLogs.append(newLog)
        saveToFile()
    }
    
    func saveToFile() {
        // Code to save foodlogs to file
    }
    
    func loadFromFile() {
        // Code to load foodlogs from a file
    }
}
