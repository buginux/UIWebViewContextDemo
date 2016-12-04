//
//  XGContact.h
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <Foundation/Foundation.h>

@protocol XGContextJS <JSExport>

+ (instancetype)contactWithName:(NSString *)name
                          phone:(NSString *)phone
                        address:(NSString *)address;

@end

@interface XGContact : NSObject <XGContextJS>

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *phone;
@property (strong, nonatomic, readonly) NSString *address;

@end
