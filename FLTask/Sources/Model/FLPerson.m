//
//  FLPerson.m
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import "FLPerson.h"
#import "FLImage.h"


@interface FLPerson ()

@end

@implementation FLPerson

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
			@"userName" : @"username",
			@"firstName" : @"firstName",
			@"lastName" : @"lastName",
			@"images" : @"avatars",
			@"allowDisplayFullName" : @"allowDisplayFullName"
    };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)aKey
{
	if ([aKey isEqualToString:@"images"])
	{
		return [MTLJSONAdapter arrayTransformerWithModelClass:[FLImage class]];
	}
	return nil;
}

- (NSString *)fullName
{
	NSString *theFullName = nil;
	if ([self.allowDisplayFullName boolValue])
	{
		if (self.firstName)
		{
			theFullName = self.firstName;
		}
		
		if (self.lastName)
		{
			if (0 == [theFullName length])
			{
				theFullName = self.lastName;
			}
			else
			{
				theFullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
			}
		}
	}
	return theFullName;
}

- (NSURL *)imageURL
{
	NSString *theImagePath = nil;
	for (FLImage *theImage in self.images)
	{
		if (theImage.imageURL != nil && ![theImage.imageURL isEqual:[NSNull
		 null]])
		 {
		 	theImagePath = [theImage imageURL];
			break;
		 }
	}
	return [NSURL URLWithString:theImagePath];
}

@end
