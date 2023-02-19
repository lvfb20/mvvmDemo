# Cabify Challenge
## To do

Implement an app where a user can pick products from a list and checkout them to get the resulting price. No need to implement any real payment system, but we do need a nice user experience where our customers can understand what items are they purchasing, the price and the discount we are applying.

## Approach

I have approached the challenge using:
- A folder structure inspired on Clean Architecture. 
- MVVM + Coordinators architecture to manage the screens and navigation.

## Folder Structure

AppDelegate: Manage everything related to AppDelegate and SceneDelegate
SupportingFiles: Group files such as GoogleServices.plist files
Data: Manage repositories implementation, network operations, and database access. 
Domain: Manage all the business logic of our app such as models, useCases
Presentation: Group all UI elements in a Commons folder for those components that are considered reusable across multiples screens, a Base folder to group BaseViewController and base protocols, and a Feature folder that groups all the features of our app. Each feature has its own folder to group ViewController, ViewModel, ViewControllerXib and a Cells folder if needed.
Utils: Group extensions, helpers..
Resources: Group Localizable files, assets, font files..
Theme: Manage global styles, Colors, Images..

## Considerations

- Two main features: ProductList and Checkout
- Shopping Cart modelated as a dictionary to avoid extra complexity
- Simple UX/UI
- Unit Tests implementation following the similar folder structure of Project Target
- UI Test not implemented

