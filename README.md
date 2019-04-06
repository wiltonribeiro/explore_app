# Photography Explorer Flutter App
App concept created with [Flutter](https://flutter.dev/) using Dart programming language, inspired by [Multi Search By Categories](https://dribbble.com/shots/5922034-Multi-search-by-categories). 

## About
This app was created inspired by the GIF in the end of this page. The code was built to better create a real app, identical to the inspiration and with all logic behind it. This app is using Unsplash API as service to search the photos and Shared Preferences to register the favorite user photos in the cache memory. The model's classes were created to better represent an official development, the services classes are responsible for the boundaries of the system like the API and Cache management library. I'm using BLOC pattern as an architectural pattern.

### Unsplash API
This app used [Unsplash API](https://unsplash.com/developers) as Photography Search Engine. It's for free, so if you want to fork this repository and reuse the code, be sure to use your Access Key at this [classe](./lib/services/PhotosAPI.dart). Then the app will run perfectly. 

### Design and Implementation Details
The inspiration video just shows the User Experience when searching for some categories in the app. This app brings something more like Favorites Photos, Personalized Bottom Menu Bar, Image Details, API Request Structure and more.

### The Inspiration
The GIF below shows the inspiration concept app.

![App Running](./docs/inspiration.gif)

### The App
The GIF below shows this current app running.

![App Running](./docs/app-running.gif)

#### Notes
The Download Image feature was not made just because that was not the purpose of this challenge but feel free to change it.
