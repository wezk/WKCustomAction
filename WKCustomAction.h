//
//  WKCustomAction.h
//  WKCustomAction
//
//  Created by Wesley Caldas on 1/23/16.
//  Copyright © 2016 Wesley Caldas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WKCustomAction : NSObject<UIGestureRecognizerDelegate>
-(void)getSelected:(UIGestureRecognizer *)sender andHandler:(void (^)(void))completionBlock;
-(instancetype)setupLongPressForWebView:(WKWebView *)theWebView;



@property (retain,nonatomic)NSString *linkhref;
@property (retain,nonatomic)NSString *imgsrc;

@end
