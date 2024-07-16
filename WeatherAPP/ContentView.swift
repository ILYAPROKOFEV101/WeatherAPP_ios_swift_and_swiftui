//
//  ContentView.swift
//  WeatherAPP
//
//  Created by Ilya Prokofev on 13.07.2024.
//

import SwiftUI
import ColorSync

struct ContentView: View {
    @State private var textInput: String = ""
    @State private var weatherData: WeatherData?
    @State private var errorMessage: String?
    @State private var savedCities: [String] = UserDefaults.standard.stringArray(forKey: "savedCities") ?? []

    var body: some View {
        VStack {
            HStack {
                TextField("Введите город", text: $textInput)
                    .padding(8)
                    .frame(height: 60)
                    .background(Color(.systemGray6))
                    .cornerRadius(60)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.leading], 10)
                
                Button(action: {
                    if !textInput.isEmpty {
                        fetchWeather(for: textInput)
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding([.trailing], 10)
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            if let weather = weatherData {
                weatherCard(weather: weather)
            } else if let error = errorMessage {
                errorCard(error: error)
            }
            
            Spacer() // This spacer pushes the cards to the bottom
            
            VStack {
                          Text("Выбранные города")
                              .font(.headline)
                              .padding()

                          // Прокручиваемые карточки
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                                  ForEach(Array(savedCities.enumerated()), id: \.offset) { index, city in
                                      CityCardView(city: city, index: index, onDelete: deleteCity, onSelect: fetchWeather)
                                    
                                  }
                              }
                    .padding(.bottom, CGFloat(savedCities.count) * 30) // Динамический отступ
                          }
                          .frame(maxHeight: 140) // Ограничиваем высоту прокручиваемого контента
                      }
                      .frame(maxWidth: .infinity)
                      .background(Color(red: 90/255, green: 196/255, blue: 246/255))
                  }
                  .padding()
                  .background(Color(red: 90/255, green: 196/255, blue: 246/255))
                  .frame(maxHeight: .infinity, alignment: .bottom)
              }
    
    
    
        // карточка погоды
    private func weatherCard(weather: WeatherData) -> some View {
    
        VStack {
            HStack {
                Text("\(weather.name)")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(5) // Уменьшение внутреннего отступа
                    }
                        .background(Color(red: 90/255, green: 196/255, blue: 246/255))
                        .cornerRadius(30) // Уменьшение радиуса закругления
                        .padding([.leading, .trailing], 5) // Уменьшение внешних отступов
    
            
            Spacer().frame(height: 15)
            
            HStack {
                Text("Температура: \(String(format: "%.1f", weather.main.temp - 273.15))°C")
                Text(weatherInfo(for: weather.weather.first?.main ?? "").0) // Русское название погоды
                weatherIcon(for: weather.weather.first?.main ?? "")
                }
            
            Spacer().frame(height: 15)
            
            HStack {
                Text("Как ощющается: \(String(format: "%.1f", weather.main.feels_like - 273.15))°C")
                weatherFeelsLikeIcon(for: weather.main.feels_like - 273.15)
            }
            
            Spacer().frame(height: 15)
            
            HStack {
                Text("Давление: \(weather.main.grnd_level)")                
                Grnd_levelIcon(for: weather.main.grnd_level)
            }
            Spacer().frame(height: 15)	
            
            HStack {
                Text("Влажность: \(weather.main.humidity)")
                humidityIcon(for: weather.main.humidity)
            }							
            
            Spacer().frame(height: 20)
            
            Button(action: {
                        saveCityName(textInput)
                        print("Button pressed! Saved city: \(weather.name)")
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .imageScale(.large)
                            .foregroundColor(Color(red: 90/255, green: 196/255, blue: 246/255))
                            .padding([.trailing], 10)
                    }

        
            
        }
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 5)
            .padding([.leading, .trailing], 10)
        
    }

    

    // Функция для получения погоды
      func fetchWeather(for city: String) {
          guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=") else {
              self.errorMessage = "Invalid city name."
              self.weatherData = nil
              return
          }

          // Сброс старых данных перед выполнением нового запроса
          self.weatherData = nil
          self.errorMessage = nil

          let request = URLRequest(url: url, timeoutInterval: 30)

          URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  DispatchQueue.main.async {
                      self.errorMessage = "Error: \(error.localizedDescription)"
                  }
                  return
              }

              guard let data = data else {
                  DispatchQueue.main.async {
                      self.errorMessage = "No data received"
                  }
                  return
              }

              do {
                  let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                  DispatchQueue.main.async {
                      self.weatherData = weatherData
                      self.errorMessage = nil
                  }
              } catch {
                  DispatchQueue.main.async {
                      self.errorMessage = "Decoding error: \(error.localizedDescription)"
                  }
              }
          }.resume()
      }
  

    
    // Функция для сохранения названия города
        func saveCityName(_ name: String) {
            if !savedCities.contains(name) {
                savedCities.append(name)
                UserDefaults.standard.set(savedCities, forKey: "savedCities")
            }
        }
    
    // Функция для удаления города
       func deleteCity(at index: Int) {
           savedCities.remove(at: index)
           UserDefaults.standard.set(savedCities, forKey: "savedCities")
       }

}

#Preview {
   // weatherCard()
    ContentView()
}



private func errorCard(error: String) -> some View {
    Text("Error: \(error)")
        .foregroundColor(.red)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.leading, .trailing], 10)
}


struct CityCardView: View {
    var city: String
    var index: Int
    var onDelete: (Int) -> Void
    var onSelect: (String) -> Void
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        Text(city)
            .font(.system(size: 18))
            .padding()
            .frame(maxWidth: .infinity, minHeight: 90, alignment: .topLeading)
            .multilineTextAlignment(.leading)
            .background(cardColor(for: index))
            .cornerRadius(30)
            .shadow(radius: 5)
            .offset(x: offset, y: CGFloat(index * 40))
            .padding([.leading, .trailing], 10)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 0 {
                            self.offset = gesture.translation.width
                        }
                    }
                    .onEnded { gesture in
                        if gesture.translation.width < -100 {
                            withAnimation {
                                onDelete(index)
                            }
                        } else {
                            withAnimation {
                                self.offset = 0
                            }
                        }
                    }
            )
            .onTapGesture {
                onSelect(city)
            }
    }

}
