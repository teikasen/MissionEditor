//
//  GameModule.h
//  test
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModule : NSObject

@property (nonatomic,copy) NSString *moduleId;
@property (nonatomic,copy) NSString *moduleName;
@property (nonatomic,copy) NSString *parameterList;
@property (nonatomic,copy) NSData *icon;

+ (instancetype)gameModuleWith:(NSString *)moduleId moduleName:(NSString *)name parameterList:(NSString *) list iconImage:(NSData *) icon;

@end
