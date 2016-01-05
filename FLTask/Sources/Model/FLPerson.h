//
//  FLPerson.h
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import <Mantle/Mantle.h>

//Only needed properties are presented in model object;

@interface FLPerson : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *personId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *allowDisplayFullName;
@property (nonatomic, strong) NSArray *images;

- (NSString *)fullName;
- (NSURL *)imageURL;

@end
