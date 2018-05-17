### initialize PAM client in AppDelegate
 
AppDelegate.m
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    NSString* pamURL = @"http://pam--------.com";
    NSString* pamAppId = "123456";

    [PAM initPam:pamURL appId:pamAppId];

    return YES;
}
```
  
## Tracking your Activity pageview 
 
ViewController.m
```objc
  -(void)viewDidLoad{
    [PAM trackPageViewWithPagename:"home"];
  }
```

## Make Form Submit. 

### When you receive form submission from your app, you can forward those form data to PAM by calling submitForm method

```objc
  NSString *formId = @"1234";
  Form *form = [Form formWithFormId:formId];

  [form addFieldName:@"email" value:@"customerEmail@gmail.com"];
  [form addFieldName:@"line_id" value:@"customerLineID"];

  [PAM submitForm:form];

```
 