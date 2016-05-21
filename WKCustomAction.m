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
                        CGSize viewSize = [webView frame].size;
                        CGSize windowSize = size;
                        
                        CGFloat f = windowSize.width / viewSize.width;
                        point.x = point.x * f;
                        point.y = point.y * f;

                        pt = point;
                        
                        NSString *path = [[NSBundle mainBundle] pathForResource:@"js" ofType:@"js"];
                        NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                        [webView evaluateJavaScript:jsCode completionHandler:nil];
                        
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
                                    
                                    
                                    // Get image link if available
                                    if ([tags rangeOfString:@",IMG,"].location != NSNotFound) {
                                        self.imgsrc = tagsSRC;
                                    }
                                    // Get link
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
