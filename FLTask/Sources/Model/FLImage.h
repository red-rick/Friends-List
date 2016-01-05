//
//  FLImage.h
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FLImage : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSString *type;

@end
