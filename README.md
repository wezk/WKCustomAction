# WKCustomAction
create custom WKWebView actionsheet

How it works:

Add the following files to your project:
WKCustomAction.h
WKCustomAction.m
js.js

on ViewDidLoad create an UIGestureReconizer and add its delegate:
```			
AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UILongPressGestureRecognizer *lpgr1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ShowActionSheet:)];
    lpgr.delegate = self;
    lpgr.minimumPressDuration = 0.6;
    [appDelegate.window addGestureRecognizer:lpgr];
 ```  
Then the ShowActionSheet: method:

```
WKCustomAction *ac = [[WKCustomAction alloc]setupLongPressForWebView:webView];
    [ac getSelected:sender andHandler:^{
       
        NSLog(@"Selected Link %@",ac.linkhref);
        NSLog(@"Selected Image %@",ac.imgsrc);
        
    }];
    ```
