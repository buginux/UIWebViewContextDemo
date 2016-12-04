//
//  XGContactStore.m
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import "XGContactStore.h"
#import "XGContact.h"

@interface XGContactStore ()

@property (strong, nonatomic) NSMutableArray *contacts;

@end

@implementation XGContactStore

- (NSMutableArray *)contacts
{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)addContact:(XGContact *)contact {
    if (contact) {
        [self.contacts addObject:contact];
    }
}

- (NSUInteger)numberOfContacts
{
    return [self.contacts count];
}

- (XGContact *)contactAtIndex:(NSUInteger)index
{
    if (index <= [self.contacts count]) {
        return [self.contacts objectAtIndex:index];
    }
    
    return nil;
}

- (void)insertContact:(XGContact *)contact atIndex:(NSUInteger)index
{
    if (index <= [self.contacts count]) {
        [self.contacts insertObject:contact atIndex:index];
    }
}

- (void)removeContactAtIndex:(NSUInteger)index
{
    if (index < [self.contacts count]) {
        [self.contacts removeObjectAtIndex:index];
    }
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithString:@"No contacts"];
    
    if ([self.contacts count] > 0) {
        XGContact *contact = self.contacts[0];
        description = [NSMutableString stringWithFormat:@"Contacts: %@", contact.name];
    }
    
    if ([self.contacts count] > 1) {
        for (NSUInteger index = 1; index < [self.contacts count]; index++) {
            XGContact *contact = self.contacts[index];
            [description appendString:[NSString stringWithFormat:@", %@", contact.name]];
        }
    }
    
    return description;
}

@end
