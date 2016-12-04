//
//  XGContactStore.h
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <Foundation/Foundation.h>

@class XGContact;

@protocol XGContactStoreJS <JSExport>

- (void)addContact:(XGContact *)contact;

@end

@interface XGContactStore : NSObject <XGContactStoreJS>

- (NSUInteger)numberOfContacts;
- (XGContact *)contactAtIndex:(NSUInteger)index;
- (void)insertContact:(XGContact *)contact atIndex:(NSUInteger)index;
- (void)removeContactAtIndex:(NSUInteger)index;

@end
