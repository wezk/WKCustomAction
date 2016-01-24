//
//  WKCustomAction.m
//  WKCustomAction
//
//  Created by Wesley Caldas on 1/23/16.
//  Copyright © 2016 Wesley Caldas. All rights reserved.
//

#import "WKCustomAction.h"

@implementation WKCustomAction{
    WKWebView *webView;
}



-(instancetype)setupLongPressForWebView:(WKWebView *)theWebView{
    
    webView = theWebView;
    return self;
}


-(void)getSelected:(UIGestureRecognizer *)sender andHandler:(void (^)(void))completionBlock{
    

    if(sender.state == UIGestureRecognizerStateBegan){
    
        __block CGPoint pt;
        __block CGSize size;
        
        
        
        [webView evaluateJavaScript:@"window.innerWidth" completionHandler:^(id result, NSError * _Nullable error) {
            
            size.width = [result integerValue];
            
            [webView evaluateJavaScript:@"window.innerHeight" completionHandler:^(id result2, NSError * _Nullable error) {
                
                size.height = [result2 integerValue];
                
                [webView evaluateJavaScript:@"window.pageXOffset" completionHandler:^(id resul3, NSError * _Nullable error) {
                    
                    pt.x = [resul3 integerValue];
                    
                    [webView evaluateJavaScript:@"window.pageYOffset" completionHandler:^(id result4, NSError * _Nullable error) {
                        
                        CGPoint point = [sender locationInView:webView];
                        // convert point from view to HTML coordinate system
                        CGSize viewSize = [webView frame].size;
                        CGSize windowSize = size;
                        
                        CGFloat f = windowSize.width / viewSize.width;
                        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.) {
                            point.x = point.x * f;
                            point.y = point.y * f;
                        } else {
                            // On iOS 4 and previous, document.elementFromPoint is not taking
                            // offset into account, we have to handle it
                            CGPoint offset = pt;
                            point.x = point.x * f + offset.x;
                            point.y = point.y * f + offset.y;
                        }
                        
                        
                        pt = point;
                        
                        
                        NSString *path = [[NSBundle mainBundle] pathForResource:@"JSTools" ofType:@"js"];
                        NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                        [webView evaluateJavaScript:jsCode completionHandler:nil];
                        
                        // get the Tags at the touch location
                        __block NSString *tags;
                        __block NSString *tagsHREF;
                        __block NSString *tagsSRC;
                        
                        
                        [webView evaluateJavaScript:[NSString stringWithFormat:@"MyAppGetHTMLElementsAtPoint(%i,%i);",(int)pt.x,(int)pt.y] completionHandler:^(id result, NSError * _Nullable error) {
                            tags = result;
                            [webView evaluateJavaScript:[NSString stringWithFormat:@"MyAppGetLinkHREFAtPoint(%i,%i);",(int)pt.x,(int)pt.y] completionHandler:^(id result2, NSError * _Nullable error) {
                                tagsHREF = result2;
                                [webView evaluateJavaScript:[NSString stringWithFormat:@"MyAppGetLinkSRCAtPoint(%i,%i);",(int)pt.x,(int)pt.y] completionHandler:^(id result3, NSError * _Nullable error) {
                                    
                                    tagsSRC = result3;
                                    
                                    
                                    self.linkhref = @"";
                                    self.imgsrc = @"";
                                    
                                    
                                    // If an image was touched, add image-related buttons.
                                    if ([tags rangeOfString:@",IMG,"].location != NSNotFound) {
                                        self.imgsrc = tagsSRC;
                                    }
                                    // If a link is pressed add image buttons.
                                    if ([tags rangeOfString:@",A,"].location != NSNotFound){
                                        self.linkhref = tagsHREF;
                                    }
                                    
                                    
                                    if([NSString stringWithFormat:@"%@,%@",self.linkhref,self.imgsrc].length > 0){
                                        completionBlock();
                                    }
                                    
                                }];
                            }];
                        }];
                        
                        
                        
                        
                    }];
                }];
            }];
        }];

    }
    
    
}



@end
