# PamSdk-iOS
Clien SDK to access PAM

## Requirements

 * Objective-C, Swift 3

## Installation

 1. Clone or download this repository
    
 1. Choose Swift or Objective-C Project
 ![PAM project](https://raw.githubusercontent.com/pushandmotion/PAM-Client-iOS/master/screenshot/project.png)

 1. Add PAM Client as your sub project (you also can copy the source code to your xCode project)
 ![import arr](https://raw.githubusercontent.com/pushandmotion/PAM-Client-iOS/master/screenshot/subproject.png)
 
 1. Link pamservice.framework to your project
 ![import arr](https://raw.githubusercontent.com/pushandmotion/PAM-Client-iOS/master/screenshot/linkframework.png)
 
## Usage

### Init PAM Client

 1. initialize PAM client in MainApplication.java
 
    AppDelegate.swift
    ```swift
      import UIKit
      import pamservices

      @UIApplicationMain
      class AppDelegate: UIResponder, UIApplicationDelegate {

          var window: UIWindow?

          func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

              let pamURL = "http://pam...url....com/"
              let pamAppId = "testAppID_111111"
              PAM.initPam(pamURL, appId: pamAppId)

              return true
          }

      }
    ```
  
 1. Tracking your Activity pageview 
 
    ViewController.swift
    ```Swift
      import UIKit
      import pamservices

      class ViewController: UIViewController {

          override func viewDidLoad() {
              super.viewDidLoad()

              PAM.trackPageView(withPagename: "home")
          }
      }
    ```
  
 1. If you want to tracking the custom data field you can using the code below.
 
    ViewController.swift
    ```swift
      import UIKit
      import pamservices

      class ViewController: UIViewController {

          override func viewDidLoad() {
              super.viewDidLoad()

              let customField = [
                  "email":"customerEmail@gmail.com",
                  "line_id":"customerLineID"
                  ]
              PAM.trackCustomField(customFields: customField)
          }
      }
    ```
  
 1. If you want to tracking Pam encrypting data ( also called as "UPDFH" ) you can using the code below.
 
    ```swift
     PAM.trackUpdfh(updfhString)
    ```
 
