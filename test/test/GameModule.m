//
//  GameModule.m
//  test
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import "GameModule.h"

@implementation GameModule


+ (instancetype)gameModuleWith:(NSString *)moduleId moduleName:(NSString *)name parameterList:(NSString *)list iconImage:(NSData *)icon{
    GameModule *gameModule = [[GameModule alloc] init];
    gameModule.moduleId = moduleId;
    gameModule.moduleName = name;
    gameModule.parameterList = list;
    gameModule.icon =icon;
    return gameModule;
}


@end
