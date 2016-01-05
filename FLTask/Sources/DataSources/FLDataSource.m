//
//  FLDataSource.m
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import "FLDataSource.h"
#import "AFURLSessionManager.h"
#import "FLPerson.h"

NSString *const kFLDataSourceURL = @"https://uapi-front.etoro.com/api/v1/users/aggregatedInfo?cidList=[3781882,1495250,4246140,4285693,1168587,2700801,692008]&realcid=true&avatar=true&fromat=json";
NSString *const kFLDataSourcePersonsKey = @"users";

@interface FLDataSource ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSArray *items;

@end

@implementation FLDataSource

@synthesize dataTask;

- (NSURLSessionDataTask *)dataTask
{
	if (nil == dataTask)
	{
		NSURLSessionConfiguration *theConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		AFURLSessionManager *theManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:theConfiguration];

		NSURL *theURL = [NSURL URLWithString:kFLDataSourceURL];
		NSURLRequest *theRequest = [NSURLRequest requestWithURL:theURL];

		__weak typeof (self) theSelf = self;

		dataTask = [theManager dataTaskWithRequest:theRequest
			completionHandler:^(NSURLResponse *aResponse, id aResponseObject, NSError *anError)
			{
			 	NSError *theError = nil;
				[theSelf updateItemsWithDictionary:aResponseObject error:&theError];
				
				if ([theSelf.delegate respondsToSelector:@selector(dataSource:didFinishLoadingWithError:)])
				{
					theError = (anError && anError.code != -999 )? anError : theError; // scip "user cancel" errors
					[theSelf.delegate dataSource:theSelf didFinishLoadingWithError:theError];
				}
		}];
	}
	return dataTask;
}

- (void)startLoading
{
	[self cancel];
	if ([self.delegate respondsToSelector:@selector(dataSourceWillStartLoading:)])
	{
		[self.delegate dataSourceWillStartLoading:self];
	}
	[self.dataTask resume];
}

- (void)cancel
{
	if (nil != dataTask)
	{
		[dataTask cancel];
		dataTask = nil;
	}
}

#pragma mark - Model Info

- (NSInteger)numberOfItems
{
	return [self.items count];
}

- (FLPerson *)itemForIndexPath:(NSIndexPath *)anIndexPath
{
	NSInteger theIndex = anIndexPath.row;
	
	if (theIndex < [self.items count])
	{
		return self.items[theIndex];
	}
	
	return nil;
}

#pragma mark - Private

- (void)updateItemsWithDictionary:(NSDictionary *)aDictionary error:(NSError **)anError;
{
	NSArray *theArray = aDictionary[kFLDataSourcePersonsKey];
	if ([theArray count] > 0)
	{
		self.items = [MTLJSONAdapter modelsOfClass:[FLPerson class] fromJSONArray:theArray error:anError];
	}
}

@end
