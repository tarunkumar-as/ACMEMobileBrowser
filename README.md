# ACME Mobile Browser

The ACME Mobile Browser is an iOS that helps users to browse the web-based on their choice. The mobile app acts as a Browser and uses the WebView component and uses it render the web pages based on the address that is given by the user. From the app, a user can navigate forward and backward from a current webpage, create additional tabs and navigate through them thereby enabling the user to keep track of multiple web pages at the same time.

The application is entirely written in Swift and makes use of Apple's UIKit framework displaying the UI components. The webView that renders the webpage is implemented using the WKWebView component of the WebKit Framework. The files are structured in a functional aspect of the code and hence make it easier for the developer to navigate through the file structure find the desired file.

## How to run the app
The application can run on the simulator the usual way by selecting the device on which the application must run. Once the simulator is selected, the play icon on the top left side of the XCode must be pressed (or Cmd + R) to run the application.

## Features Implemented
1. A user can type the address of the URL he wants to navigate to and access the webpage of the given URL
2. Once a webpage is loaded he can reload the page by pressing the reload button(bottom left of the page in portrait orientation and top left in landscape orientation)if he/she wants to reload the page. 
3. If a user navigates further more or to the next Url of the webpage, the user can also navigate back to the previous page and once back can navigate forward to the page that was viewed.
4. To keep track of multiple instances, a user can add tabs and view and keep track of multiple web pages at the same time.
5. There is also a tab switcher from which a user can select which tab he/she wants to view. The tab switcher has thumbnails depicting the last screen that was visible to the user before changing the tab. This way it easier for the user to switch between tabs.
6. Proper error has been implemented from which a user will be able to see the kind of error a web page throws and hence to take actions based on the message.
7. The application supports orientation handling where the design of the browser changes slightly to make use of the large width in landscape mode and large height in portrait.
8. Handling to iPad devices has also been implemented making the app to be run on iPad devices too.

## Application Design
- As mentioned earlier the files of the application are structured in a way that matches its functionality. This way it easier for a developer to navigate to a file by just knowing the file's functionality.
- Since the application is a View only application, there wasn't any use of the Model or the Controller in the case of MVC architecture or a Presenter layer, Interactor layer, Entity Layer, or Repository layer in case of VIPER architecture.
- The components are plug-in components, meaning that if in the future if a component were to be replaced the component following the given protocols can be implemented.
- The entire application is written in Swift and makes use UIKit and WebKit. This can however be easily migrated to SwiftUI by changing the UI components to the latest framework.

## ScreenShot
/Users/tarun/Desktop/Simulator Screen Shot - iPhone 12 Pro - 2021-03-22 at 19.45.43.png
/Users/tarun/Desktop/Simulator Screen Shot - iPhone 12 Pro - 2021-03-22 at 19.45.57.png

## Future Work
- A few other feature that can be implemented is making the app use a database to keep track of the user activity. By implementing feature, the app can load the sessions or last viewed webpages and tabs when the app is closed and launched again.
- Making of the database can also store bookmarks and other user settings.
- The next important feature that is required in a mobile browser is the In Private Browsing mode which will disable the user trakcing feature mentioned in the above points.
- Have a seperate folder to download the documents or other downloadable content and view them from the files app.

## References
All the icons that are used in the application are copyrighted to "https://www.flaticon.com/" and may not be used to distribution purposes.
