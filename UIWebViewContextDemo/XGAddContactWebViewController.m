//
//  XGAddContactWebViewController.m
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import "XGAddContactWebViewController.h"
#import "NSObject+JSContextTracker.h"
#import "XGContact.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface XGAddContactWebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation XGAddContactWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [self.loadingView startAnimating];
    
    self.jsContext = [NSObject contextForWebView:self.webView];
    
    self.title = @"Adding a Contact";
    [self loadAddContactHTML];
}

- (void)loadAddContactHTML {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"add_a_contact" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.loadingView stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView stopAnimating];
    
    [self.jsContext setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"WEB JS: %@", value);
    }];
    
    self.jsContext[@"myStore"] = self.store;
    self.jsContext[@"XGContact"] = [XGContact class];
    
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"add_a_contact" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [self.jsContext evaluateScript:jsCode];
}

@end
