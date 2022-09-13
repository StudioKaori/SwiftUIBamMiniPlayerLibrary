# SwiftUIBamMiniPlayerLibrary

WebView mini player on Swift UI

# Installation

Copy the Github url and load it in your Swift package manager

# Usage

### Observable objects
####PlayerStatus.shared
PlayerStatus.shared has the following mutable properties. By observing the properties, you can know the player status.

isPlayerViewVisible: Bool
isPlayerMinimised: Bool
showID: String

####PlayerMessageHandler.shared
PlayerStatus.shared has the following mutable properties. By observing the properties, you can manupilate the child view (mainly for the product) and which product is tapped.

isChildViewVisible: Bool
currentProduct: Product (tapped product on the player)

####Product
Product has the following properties.
public let id: UUID = UUID()
public let sku: String
public let title: String
public let url: String


Example code:

```
import SwiftUI
import SwiftUIBamMiniPlayerLibrary

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var playerStatus = PlayerStatus.shared
    @StateObject private var playerMessageHandler = PlayerMessageHandler.shared
    
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                VStack{
                    NavigationLink(destination: {
                        ProductPageView()
                    }, label: {
                        Text("Product page")
                    })
                    .padding()
                    
                    Button(action: {
                        playerStatus.isPlayerViewVisible ? PlayerWebView.shared.playerClose() :  PlayerWebView.shared.playerOpen(showID: "vAtJH3xevpYTLnf1oHao") 
                    }, label: {
                        Text(playerStatus.isPlayerViewVisible ? "Close the player" : "Open the player")
                        
                    })
                    
                    NavigationLink(destination: ProductPageView(), isActive: $playerMessageHandler.isChildViewVisible, label: {
                        EmptyView()
                    })
                } //: VStack
            } //: Navigation View
            
            // Player
            PlayerView()

            
        } //: Zstack

    }
}
```


# Update

#### 2022/09/12 update
### Cannot load the local html file to the Webview to play the video

To include the local html as available resources, I have added resources to the .target in the package.swift. 
I found that for Swift package manager, I need to use Bundle.module instead of Bundle.main.
When I build it, it looked like 

In Package.swift
```
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite. 
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftUIBamMiniPlayerLibrary",
            dependencies: [],
            resources: [
                .copy("Resources/player.html")
            ]),
        .testTarget(
            name: "SwiftUIBamMiniPlayerLibraryTests",
            dependencies: ["SwiftUIBamMiniPlayerLibrary"]),
    ]
```

To use the resources
```
let path: URL = Bundle.module.url(forResource: "player", withExtension: "html")
```

When I build it, path didn't return the url, however, when I anyway build it and became Swift package, it worked well in the demo project.

Later, I will test .process instead of .copy.


#### 2022/09/09 update
### Created SwiftUIBamMiniPlayerLibrary for Swift package manager 
The package is made based on [SwiftUIBamMiniPlayer](https://github.com/StudioKaori/SwiftUIBamMiniPlayer)


#### 2022/09/08 update
### Published variables and methods
Published variables

PlayerStatus.shared.isPlayerViewVisible: Bool = false
PlayerStatus.shared.isPlayerMinimised: Bool = false
PlayerStatus.shared.showID: String = “"

Player methods

PlayerWebView.shared.playerOpen(showID: String)
PlayerWebView.shared.playerClose()
PlayerWebView.shared.playerMinimise()
PlayerWebView.shared.playerMakeFullSize()

### Issue: set a show ID from the openPlayer method

#### -> To make this solution to the Swift package, the user can open the player with any showID.
Updated the method openPlayer to .openPlayer(showID), so that the user can open the player with any show ID.


#### 2022/09/04 update
### Issue: How to evaluate JS from the all Swift UI components?

#### -> Make the webview instance static.
Next possible issue: Waist of memory?


#### 2022/09/03 update
### Issue: How to programmatically push page in navigation view?

#### -> use isActive property for navigation link
```
            NavigationView {
                VStack{
                    NavigationLink(destination: {
                        ProductPageView()
                    }, label: {
                        Text("Product page")
                    })
                    
                    // The navigation link can be manipulate by playerStatus.isChildViewVisible status
                    NavigationLink(destination: ProductPageView(), isActive: $playerStatus.isChildViewVisible, label: {
                        EmptyView()
                    })
                } //: VStack    
            } //: Navigation View
```
Note:
- Use EmptyView for label
- Navigation view takes only one view. Use V/Z/HStack

### Issue: Non SwiftUI View class cannot access to Environmental object

Message handler class is dealing with communication between JS on Webview and native app. But it’s non SwiftUI View class and cannot access to Environmental object

#### -> Change Message Handler to a singleton object

Message Handler class will be the owner of the player statuses (isPlayerViewVisible, isPlayerMinimised) instead of the Environmental object.

To hold consistent player statuses, I created singleton instance of Message Handler (name: MessageHandler.shared)
Later, the project was refactored, and a new observable object class 'PlayerStatus' was made for holding player status.

### Issue: To make mini player visible over the other view

The mini player must be over any visible views such as product page, home page etc

#### -> Set playerView over the navigation link

So that the playerView is always top of any views (pages)

For that, declared the following observable variables in Environmental project

```
@Published var isPlayerViewVisible: Bool = false
@Published var isPlayerMinimised: Bool = false
```


# License
[MIT](https://choosealicense.com/licenses/mit/)

