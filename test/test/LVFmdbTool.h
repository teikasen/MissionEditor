//
//  LVFmdbTool.h
//  LVDatabaseDemo
//
//  Created by 刘春牢 on 15/3/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class LVModal;
@class GameModule;

@interface LVFmdbTool : NSObject

// 插入模型数据
+ (BOOL)insertModal:(LVModal *)modal;

/** 查询数据,如果 传空 默认会查询表中所有数据 */
+ (NSArray *)queryData:(NSString *)querySql;

/** 删除数据,如果 传空 默认会删除表中所有数据 */
+ (BOOL)deleteData:(NSString *)deleteSql;

/** 修改数据 */
+ (BOOL)modifyData:(NSString *)modifySql;


//GameModule 游戏模块增删改查

/** 插入游戏模块*/
+ (BOOL)insertGameModule:(GameModule *)gameModule;

/** 通过游戏模块ID删除游戏模块*/
+ (BOOL)deleteGameModuleByModuleId:(NSString *) moduleId;

/** 通过游戏模块ID更改游戏模块*/
+ (BOOL)modifyGameModuleByModule:(GameModule *)gameModule;

/** 模块ID为空时查询所有模块,否则更加模块ID查询*/
+ (NSArray *)queryGameModule:(NSString *)moduleId;




@end
