Это моё первое приложение на Swift и SwiftUI. Приложение простое, я делаю обычные GET-запросы на сервер и получаю данные о погоде в формате:
Я использовал сторонний API от компании провайдера погоды OpenWeatherMap:
https://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg&appid=my_key

Я распарсил эти данные и отображаю их на карточках о погоде

![image](https://github.com/user-attachments/assets/786462d5-2a75-4542-ac83-ed6749162f89)

Вот как это выглядит. Также стоит отметить, что я добавил функцию сохранения понравившихся городов в память устройства.
При каждом запуске приложения они будут у вас под рукой, и всё, что вам остаётся сделать, это нажать на эту карточку и узнать, какая там погода. 
Помимо этого, если вам не интересен этот город, вы можете удалить его, свайпнув карточку влево.  
![image](https://github.com/user-attachments/assets/c15add29-d86c-44db-b8fa-870db2843b89)

