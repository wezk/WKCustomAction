# WKCustomAction
create custom WKWebView actionsheet

How it works:

Add the following files to your project:
- WKCustomAction.h 
- WKCustomAction.m 
- js.js 

on ViewDidLoad create an UIGestureReconizer and add its delegate:
```objective-c		
AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
UILongPressGestureRecognizer *lpgr1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ShowActionSheet:)];
lpgr.delegate = self;
lpgr.minimumPressDuration = 0.6;
[appDelegate.window addGestureRecognizer:lpgr];
```  
Then the ShowActionSheet: method:

# WKCustomAction
create custom WKWebView actionsheet

How it works:

Add the following files to your project:
- WKCustomAction.h 
- WKCustomAction.m 
- js.js 

on ViewDidLoad create an UIGestureReconizer and add its delegate:

```objective-c		
AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
UILongPressGestureRecognizer *lpgr1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ShowActionSheet:)];
lpgr.delegate = self;
lpgr.minimumPressDuration = 0.6;
[appDelegate.window addGestureRecognizer:lpgr];
```  
Then the ShowActionSheet: method:

```objective-c
WKCustomAction *ac = [[WKCustomAction alloc]setupLongPressForWebView:webView];
[ac getSelected:sender andHandler:^{

if(ac.linkhref.length > 0){
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
[alert addAction:[UIAlertAction actionWithTitle:@"Copy Link" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
// your code
}]];
[alert addAction:[UIAlertAction actionWithTitle:@"Open Link" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
// your code
}]];
[self presentViewController:alert animated:YES completion:nil];
}else if(ac.imgsrc.length > 0){
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
[alert addAction:[UIAlertAction actionWithTitle:@"Open Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
// your code
}]];
[alert addAction:[UIAlertAction actionWithTitle:@"Save Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
// your code
}]];
[self presentViewController:alert animated:YES completion:nil];
}

}];
```
