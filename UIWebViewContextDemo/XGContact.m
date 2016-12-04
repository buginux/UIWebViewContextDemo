//
//  XGContact.m
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import "XGContact.h"

@interface XGContact ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;

@end

@implementation XGContact

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ <%@, %@>", self.name, self.phone, self.address];
}

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone address:(NSString *)address {
    
    XGContact *contact = [XGContact new];
    contact.name = name;
    contact.phone = phone;
    contact.address = address;
    
    return contact;
}

@end
