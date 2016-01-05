//
//  FLImage.m
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import "FLImage.h"

@implementation FLImage

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
			@"imageURL" : @"url",
			@"height" : @"height",
			@"width" : @"width",
			@"type" : @"type"
    };
}

@end
