//
//  NSObject+JSContextTracker.m
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import "NSObject+JSContextTracker.h"

@implementation NSObject (JSContextTracker)

+ (NSMapTable *)JSContextTrackerMap
{
    static NSMapTable *contextTracker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contextTracker = [NSMapTable strongToWeakObjectsMapTable];
    });
    return contextTracker;
}

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)alsoUnused
{
    NSAssert([ctx isKindOfClass:[JSContext class]], @"bad context");
    if (!ctx)
        return;
    NSMapTable *map = [NSObject JSContextTrackerMap];
    static long contexts = 0;
    NSString *contextKey = [NSString stringWithFormat:@"jsctx_%@", @(contexts++)];
    [map setObject:ctx forKey:contextKey];
    ctx[@"JSContextTrackerMapKey"] = contextKey; // store the key to the map in the context itself
}

+ (JSContext *)contextForWebView:(UIWebView *)webView
{
    // this will trigger didCreateJavaScriptContext if it hasn't already been called
    NSString *contextKey = [webView stringByEvaluatingJavaScriptFromString:@"JSContextTrackerMapKey"];
    JSContext *ctx = [[NSObject JSContextTrackerMap] objectForKey:contextKey];
    return ctx;
}

@end
