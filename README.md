# 📷 PhotoExplorer

* This example app lets users fetch pictures from different sources and list them on their devices
* The project was focused on easy integration of extra services.


![](record.gif)


## 🔌 Dependencies used 

* Kingfisher: Used for fetching and caching images locally in a easy way
 

## ⚒ Architecture 

* Models
	*  Photo 
		*  	Enum instead of a class for a clear understanding of what services we are using. 
		*   Using Unsplash, Pexel and Flickr web services for treating them as the same thing independent of their original structure. check Services in Network section
* ViewModels
	* PhotoExploreViewModel
		* Is in Charge of communicating with network operations and database for passing data to PhotoExploreViewController
* Networking
	* API
		* Base Enum for listing the different services used in app (Unsplash, Pexel and Flickr)
		* Easy integration of extra services
* Operations
	* Used for handling a async task for fetching and storing data without data-loss risk. 
* Persistance
	* DatabaseManager
		* Singleton used for hadling data storage for photos and also in charge of returning photos in a common class.
* Controllers
	* PhotoExploreViewController
		* Main Class which loads pictures 
	* PhotoDetailsViewController
		* Details of picture screen
		

## 🐞 Known Issues 
* Use of force unwrap on cells and photoEntityManagedObject. this could be improved by adding a extra layer of error handling (guard, do-catch)
* values search on string: this could be improved by adding a regex which extracts the value without extra filterings or splits (not friendly with performance) 
* Since App is thread safe, it feels like adding operations is a overkill but the idea is to support multiple services so this can be scalable for a bigger challenge
* offline mode can be implemented in a future update since data is persisted
		
## 📈 Upcoming updates
* Integrate Search box in View (API Request and operation ready)
* Adding tests for Validate stability and documentation
* Adding animations for loading, pull to refresh 


## 🔎 Please take a look at 
* https://github.com/bolivarbryan/GameCatalog
* https://github.com/bolivarbryan/PostsViewer
* https://github.com/bolivarbryan/GIPHYClient
* https://github.com/bolivarbryan/PostsFeed-ObjC
* https://github.com/bolivarbryan/DrinksROnMe
