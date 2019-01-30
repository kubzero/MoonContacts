# MoonContacts
![Image description](https://github.com/kubzero/MoonContacts/blob/master/Mooncascade/Mooncascade/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png)

Application that grab list of workers from server and compare them with existed on phone contactbook.

## Working principle
Application is fetching worker data from weblinks as JSON files and fetching contacts from phone contactbook. If data is fetched CoreData is saving all contacts to database. Next application is filtering data and show contacts in table. Contacts that exist in both sources are higlited with additional button which refere to Native iOS contatc view. User is able to refresh table with pull-to-refresh function. If device does not have internet, data will be displayed from CoreData database.

### Installing
* Download copy of application to your pc.
* Run Mooncascade.xcodeproj.
* Change developer company to your own (to be possible to isntall to your phone).
* Choose any iPhone simulator or choose your own iPhone device (previously should be connected to PC with cable).
* Start simulation.
* Phone may ask to settup from settings this developer as prooven.
* When application runs it will request for access to you contact list: 

![Image description](https://pp.userapi.com/c850120/v850120099/cd1d1/zwGqxCrVUto.jpg)

You should tap "OK". 
Access should be given in order to use all application capabilities. 

## Requirements to compile and run program
Your PC must run Xcode 10.1 
App was written on Swift 4.2 
Your idevice should be updated to iOS 12 or later.

## Used Architecture Patterns
 MVC Pattern - https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html 

## Used Frameworks
ContactsUI  - https://developer.apple.com/documentation/contactsui

CoreData - https://developer.apple.com/documentation/coredata

