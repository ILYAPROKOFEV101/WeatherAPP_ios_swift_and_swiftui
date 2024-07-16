Это моё первое приложение на Swift и SwiftUI. Приложение простое, я делаю обычные GET-запросы на сервер и получаю данные о погоде в формате:
{
  "coord": {
    "lon": 30.2642,
    "lat": 59.8944
  },
  "weather": [
    {
      "id": 802,
      "main": "Clouds",
      "description": "scattered clouds",
      "icon": "03d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 297.62,
    "feels_like": 297.61,
    "temp_min": 297.62,
    "temp_max": 299.23,
    "pressure": 1018,
    "humidity": 57,
    "sea_level": 1018,
    "grnd_level": 1016
  },
  "visibility": 10000,
  "wind": {
    "speed": 4,
    "deg": 330
  },
  "clouds": {
    "all": 40
  },
  "dt": 1721137423,
  "sys": {
    "type": 2,
    "id": 197864,
    "country": "RU",
    "sunrise": 1721091956,
    "sunset": 1721156622
  },
  "timezone": 10800,
  "id": 498817,
  "name": "Saint Petersburg",
  "cod": 200
}
Я распарсил эти данные и отображаю их на карточках о погоде
![image](https://github.com/user-attachments/assets/786462d5-2a75-4542-ac83-ed6749162f89)

Вот как это выглядит. Также стоит отметить, что я добавил функцию сохранения понравившихся городов в память устройства.
При каждом запуске приложения они будут у вас под рукой, и всё, что вам остаётся сделать, это нажать на эту карточку и узнать, какая там погода. 
Помимо этого, если вам не интересен этот город, вы можете удалить его, свайпнув карточку влево.  
![image](https://github.com/user-attachments/assets/c15add29-d86c-44db-b8fa-870db2843b89)

