//
//  FLDataSource.h
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLDataSourceDelegate;
@class FLPerson;

@interface FLDataSource : NSObject

@property (nonatomic, weak) id<FLDataSourceDelegate> delegate;

- (NSInteger)numberOfItems;
- (FLPerson *)itemForIndexPath:(NSIndexPath *)anIndexPath;

- (void)startLoading;
- (void)cancel;

@end

@protocol FLDataSourceDelegate <NSObject>

- (void)dataSource:(FLDataSource *)aDataSource didFinishLoadingWithError:(NSError *)anError;
- (void)dataSourceWillStartLoading:(FLDataSource *)aDataSource;
@end