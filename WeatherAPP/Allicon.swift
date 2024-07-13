//
//  Allicon.swift
//  WeatherAPP
//
//  Created by Ilya Prokofev on 15.07.2024.
//

import SwiftUI

func weatherIcon(for condition: String) -> some View {
      let iconName: String
      switch condition.lowercased() {
      case "clear":
          iconName = "sun.max.fill" // Измените на ваше изображение "sunny"
      case "clouds":
          iconName = "cloud.fill" // Измените на ваше изображение "cloud"
      case "rain":
          iconName = "cloud.rain.fill"
      case "snow":
          iconName = "snow"
      case "thunderstorm":
          iconName = "cloud.bolt.fill"
      default:
          iconName = "questionmark.circle"
      }
      return Image(systemName: iconName)
          .resizable()
          .frame(width: 24, height: 24)
  }

func weatherFeelsLikeIcon(for temperature: Double) -> some View {
   let emoji: String

   switch temperature {
   case 50...:
       emoji = "🥵" // Очень жарко
   case 40..<50:
       emoji = "🔥" // Жарко
   case 30..<40:
       emoji = "🌞" // Солнечно
   case 25..<30:
       emoji = "😎" // Тепло
   case 20..<25:
       emoji = "😊" // Комфортно
   case 10..<20:
       emoji = "🙂" // Прохладно
   case 0..<10:
       emoji = "🥶" // Холодно
   case -10..<0:
       emoji = "❄️" // Морозно
   case -20 ..< -10:
       emoji = "⛄️" // Снеговик
   case -30 ..< -20:
       emoji = "🧊" // Очень холодно
   default:
       emoji = "❓" // Неизвестная температура
   }

   return Text(emoji)
       .font(.system(size: 24))
}


func humidityIcon(for humidity: Int) -> some View {
    let emoji: String

    switch humidity {
    case 90...:
        emoji = "💦" // Очень высокая влажность (капли)
    case 70..<90:
        emoji = "💧" // Высокая влажность (капля)
    case 50..<70:
        emoji = "😐" // Умеренная влажность (нейтральное лицо)
    case 30..<50:
        emoji = "🙂" // Комфортная влажность (улыбка)
    case ..<30:
        emoji = "🌵" // Низкая влажность (кактус)
    default:
        emoji = "❓" // Неизвестная влажность
    }

    return Text(emoji)
        .font(.system(size: 24))
}


func Grnd_levelIcon(for pressure: Int) -> some View {
   let emoji: String

   switch pressure {
   case 1050...:
       emoji = "⚠️" // Очень высокое давление (предупреждение)
   case 1020..<1050:
       emoji = "⬆️" // Высокое давление (стрелка вверх)
   case 1000..<1020:
       emoji = "🆗" // Нормальное давление (галочка)
   case 980..<1000:
       emoji = "⬇️" // Пониженное давление (стрелка вниз)
   case ..<980:
       emoji = "🔻" // Низкое давление (треугольник вниз)
   default:
       emoji = "❓" // Неизвестное давление
   }

   return Text(emoji)
       .font(.system(size: 24))
}




func weatherInfo(for condition: String) -> (String, String) {
   switch condition.lowercased() {
   case "clear":
       return ("Ясно", "sun.max.fill")
   case "clouds":
       return ("Облачно", "cloud.fill")
   case "rain":
       return ("Дождь", "cloud.rain.fill")
   case "snow":
       return ("Снег", "snow")
   case "thunderstorm":
       return ("Гроза", "cloud.bolt.fill")
   default:
       return ("Неизвестно", "questionmark.circle")
   }
}

// Функция для определения цвета карточки
   func cardColor(for index: Int) -> Color {
       let colors: [Color] = [  Color(red: 100/255, green: 196/255, blue: 102/255), Color(red: 246/255, green: 206/255, blue: 70/255), Color(red: 255/255, green: 255/255, blue: 255/255), ] // Цвета для карточек
       return colors[index % colors.count]
   }
