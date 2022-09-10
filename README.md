# SwiftUIBamMiniPlayerLibrary

WebView mini player on Swift UI

# Installation

Copy the Github url and load it in your Swift package manager


# Update

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

