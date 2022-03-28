# Popular Movies

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)

Popular Movies App - Consumes data from [TMDB](https://developers.themoviedb.org/3) API. 
The project is structured using the MVVM design pattern. 

Preloads data while launching the splash screen. Saves it using CoreData.

It checks if there are new contents and updates the app when launched.

`URLSession` was used for making API calls. Fetching of data was safely done
on the **background** thread and the UI gets updated on the **main** thread.

This allows the user have smooth experience while running the app.

## Dark Mode

<img src="https://user-images.githubusercontent.com/22558674/160407221-394e2738-a954-4e0b-999d-a72ccfe6c5f3.png" width="300px">
<img src="https://user-images.githubusercontent.com/22558674/160407184-3e5b559a-19ee-439d-b8fe-902f543d6f56.png" width="300px"> 

## Light Mode

<img src="https://user-images.githubusercontent.com/22558674/160407231-28a43104-df7b-42b7-8d1b-b117b575d435.png" width="300px">
<img src="https://user-images.githubusercontent.com/22558674/160407237-49349d47-d5f3-453a-bf47-3b9c3f695e54.png" width="300px">
