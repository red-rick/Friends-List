//
//  FLViewController.m
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import "FLViewController.h"
#import "FLDataSource.h"
#import "FLTableViewCell.h"
#import "FLPerson.h"
#import "UIImageView+AFNetworking.h"

static NSString *sCellIdentifier = @"FLTableViewCell";

@interface FLViewController ()<UITableViewDataSource, FLDataSourceDelegate>

@property (nonatomic, strong) FLDataSource *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel *errorMessageLabel;

@end

@implementation FLViewController

@synthesize dataSource;

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.dataSource startLoading];
}

#pragma mark - Accessors 

- (FLDataSource *)dataSource
{
	if (nil == dataSource)
	{
		dataSource = [FLDataSource new];
		dataSource.delegate = self;
	}
	return dataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
	return [self.dataSource numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
	UITableViewCell *theCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier forIndexPath:anIndexPath];
	
	[self configureCell:theCell atIndexPath:anIndexPath];
	
	return theCell;
}

#pragma mark - FLDataSourceDleelgate

- (void)dataSource:(FLDataSource *)aDataSource didFinishLoadingWithError:(NSError *)anError
{
	[self updateUIAfterLoading];
	if (nil == anError)
	{
		[self.tableView reloadData];
	}
	else
	{
		[self showMessageWithError:anError];
	}
}

- (void)dataSourceWillStartLoading:(FLDataSource *)aDataSource
{
	[self updateUIBeforeLoading];
}

#pragma mark - Actions

- (IBAction)refresh:(id)sender
{
	[self.dataSource startLoading];
}

#pragma mark - Private

- (void)configureCell:(UITableViewCell *)aCell atIndexPath:(NSIndexPath *)anIndexPath
{
	FLPerson *thePerson = [self.dataSource itemForIndexPath:anIndexPath];
	FLTableViewCell *theCell = (FLTableViewCell *)aCell;
	theCell.titleLabel.text = thePerson.userName;
	theCell.infoLabel.text = [thePerson fullName];
	[theCell.iconImageView setImageWithURL:[thePerson imageURL] placeholderImage:[UIImage imageNamed:@"userpic"]];
}

- (void)showMessageWithError:(NSError *)anError
{
	self.errorMessageLabel.hidden = NO;
	self.tableView.hidden = YES;
	[self.activityIndicator stopAnimating];
	
	self.errorMessageLabel.text = [anError localizedDescription];
}

- (void)updateUIBeforeLoading
{
	self.tableView.hidden = YES;
	self.errorMessageLabel.hidden = YES;
	[self.activityIndicator startAnimating];
}

- (void)updateUIAfterLoading
{
	[self.activityIndicator stopAnimating];
	self.errorMessageLabel.hidden = YES;
	self.tableView.hidden = NO;
}

@end
