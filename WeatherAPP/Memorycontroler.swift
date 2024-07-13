//
//  Memorycontroler.swift
//  WeatherAPP
//
//  Created by Ilya Prokofev on 16.07.2024.
//

import Foundation





// Функция для получения списка сохраненных городов (если нужно)
func getSavedCities() -> [String] {
    return UserDefaults.standard.stringArray(forKey: "savedCities") ?? []
}
