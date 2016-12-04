//
//  NSObject+JSContextTracker.h
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@interface NSObject (JSContextTracker)

+ (JSContext *)contextForWebView:(UIWebView *)webView;

@end
