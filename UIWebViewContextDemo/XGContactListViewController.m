//
//  XGContactListViewController.m
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import "XGContactListViewController.h"
#import "XGAddContactWebViewController.h"
#import "XGContact.h"
#import "XGContactCell.h"
#import "XGContactStore.h"

@interface XGContactListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIBarButtonItem *addContactButton;

@end

@implementation XGContactListViewController


#pragma mark - Custom Getters and Setters

- (UIColor *)backgroundColor
{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithRed:0.1 green:0.8 blue:1.0 alpha:1.0];
    }
    return _backgroundColor;
}

- (UIBarButtonItem *)addContactButton
{
    if (!_addContactButton) {
        _addContactButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactButtonPressed)];
    }
    return _addContactButton;
}

- (XGContactStore *)store {
    if (!_store) {
        _store = [XGContactStore new];
        
        [_store addContact:[XGContact contactWithName:@"Philip J. Fry" phone:@"999 555-1999" address:@"Robot Arms Apt 00100100, Earth"]];
        [_store addContact:[XGContact contactWithName:@"Bender B. Rodriguez" phone:@"010 110-0101" address:@"Robot Arms Apt 00100100, Earth"]];
        [_store addContact:[XGContact contactWithName:@"Turanga Leela" phone:@"999 555-5309" address:@"132 Sewer Street, Earth"]];
        [_store addContact:[XGContact contactWithName:@"Amy Wong" phone:@"999 555-2811" address:@"1 Wong Way, Mars"]];
        [_store addContact:[XGContact contactWithName:@"Zapp Brannigan" phone:@"3" address:@"D.O.O.P. HQ, Earth"]];
        [_store addContact:[XGContact contactWithName:@"Lrrr" phone:@"999 555-8888" address:@"1 Palace Circle, Omicron Persei 8"]];
    }
    return _store;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = self.backgroundColor;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = self.addContactButton;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.store numberOfContacts];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the contact
    XGContact *contact = [self.store contactAtIndex:indexPath.row];
    
    // get a reusable cell
    XGContactCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactCellIdentifier forIndexPath:indexPath];
    
    // configure the cell
    cell.name.text = contact.name;
    cell.phone.text = contact.phone;
    cell.address.text = contact.address;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    XGContact *contact = [self.store contactAtIndex:sourceIndexPath.row];
    [self.store removeContactAtIndex:sourceIndexPath.row];
    [self.store insertContact:contact atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.store removeContactAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        NSLog(@"%@", self.store);
    }
}



#pragma mark - Actions

- (void)addContactButtonPressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XGAddContactWebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"XGAddContactWebViewController"];
    webViewController.store = self.store;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
