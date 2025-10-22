# BestProducts

This project is an iOS challenge for Hexa Consulting.

## Installation

### Pre-requisites

The developer must have [git](https://git-scm.com/downloads) and [XCode](https://apps.apple.com/us/app/xcode/id497799835?mt=12/) installed on a Mac computer to be able to run this project.

Go to the [Repository](https://github.com/leonardofs88/BestProducts) page and clone the project

## Run

After the project is cloned, it's just necessary to open the **BestProducts.xcodeproj**. 

> **_NOTE 1:_**  To be fully able to build the product, the developer must assure that the current branch is **main**.
> 
> **_NOTE 2:_**  In the **develop** branch, it's available to check a more refined code with ongoing changes.

> **_NOTE 3:_**  To be fully able to build the product, the developer must change the **Team** at **Signing & Capabilities** on the target's configuration.

### Run Targets

The project has two targets: **BestProduct** and **ProductForm**.
They share some code, but also they have specific code for each target.
To run a specific targtet, select the correct scheme at the top center of **XCode** IDE

##### BestProducts

This target lists data from a [remote API](https://dummyjson.com/docs/products) and the user is able to see the details of the product.

##### ProductForm

This target is a Form with validation for fields like name, email and date.

## External Libraries

For helping the app development, this project uses two external libraries.

### Swiftlint

This library is responsible to give warnings on the IDE for the developer keeps the code clean and maintanable. You can check more in [SwiftLint](https://github.com/realm/SwiftLint)

### Factory

For helping with dependency injection, the project uses Factory. It uses the container approach with easy application, testable and also with support for SwiftUI. More information at [Factory](https://github.com/hmlongco/Factory)

## Native Libraries

The project also uses **Combine** to help fetching data in a thread safe mode, **URLSessions** to communicate with the REST API, and uses **SwiftUI** framework to create the app's views.

# Conclusion

Thanks for the opportunity to have this challenge. I wish I could improve more the code I've done, and I sacrificed some of features, like testing, paging, and using SwiftData to persist data, but I could't do more in time.

My contacts are:

[GitHub](https://github.com/leonardofs88/)
leonardofs88@live.com

