### initialize PAM client in AppDelegate
 
AppDelegate.swift
```Swift
  import UIKit
  import pamservices

  @UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let pamURL = "http://pam--------.com"
        let pamAppId = "123456"
        PAM.initPam(pamURL, appId: pamAppId)

        return true
    }

  }
```
  
## Tracking your Activity pageview 
 
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

## Make Form Submit. 

### When you receive form submission from your app, you can forward those form data to PAM by calling submitForm method

```Swift
  let formId = @"1234";
  let form = Form.createFormWithFormId(formId)

  form.addField(name: "email", value: "customerEmail@gmail.com")
  form.addField(name: "line_id", value: "customerLineID")

  PAM.submitForm(form)
```
 