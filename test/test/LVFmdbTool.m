//
//  LVFmdbTool.m
//  LVDatabaseDemo
//
//  Created by 刘春牢 on 15/3/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVFmdbTool.h"
#import "LVModal.h"
#import "GameModule.h"

#define LVSQLITE_NAME @"modals.sqlite"

@implementation LVFmdbTool


static FMDatabase *_fmdb;

+ (void)initialize {
    // 执行打开数据库和创建表操作
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:LVSQLITE_NAME];
    _fmdb = [FMDatabase databaseWithPath:filePath];
    
    [_fmdb open];
    
#warning 必须先打开数据库才能创建表。。。否则提示数据库没有打开
    [_fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_modals(id INTEGER PRIMARY KEY, name TEXT NOT NULL, age INTEGER NOT NULL, ID_No INTEGER NOT NULL);"];
    
    [_fmdb executeUpdate:@"CREATE TABLE IF NO EXISTS t_gameModule(id INTEGER PRIMARY KEY, moduleId TEXT NOT NULL, moduleName TEXT NOT NULL, paraListValue TEXT NOT NULL, icon BLOB)"];
    
}

+ (BOOL)insertGameModule:(GameModule *)gameModule {
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO t_gameModule(moduleId, moduleName, paraListValue, icon) VALUES ('%@', '%@', '%@', '%@');", gameModule.moduleId, gameModule.moduleName, gameModule.parameterList, gameModule.icon];
    return [_fmdb executeUpdate:insertSql];
}





+ (BOOL)insertModal:(LVModal *)modal {
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO t_modals(name, age, ID_No) VALUES ('%@', '%zd', '%zd');", modal.name, modal.age, modal.ID_No];
    return [_fmdb executeUpdate:insertSql];
}

+ (NSArray *)queryGameModule:(NSString *)moduleId {
    
    NSString *querySql = @"";
    
    if (moduleId == nil) {
        querySql = @"SELECT * FROM t_gameModule";
    }else {
        querySql = [NSString stringWithFormat:@"SELECT FROM t_gameModule WHERE moduleId = %@;", moduleId];

    }
    
    NSMutableArray *arrGameModule = [NSMutableArray array];
    FMResultSet *set = [_fmdb executeQuery:querySql];
    
    while ([set next]) {
        NSString *moduleId = [set stringForColumn:@"moduleId"];
        NSString *moduleName = [set stringForColumn:@"moduleName"];
        NSString *parameterList = [set stringForColumn:@"paraListValue"];
        NSData *icon = [set dataForColumn:@"icon"];
        
        GameModule *gameModule = [GameModule gameModuleWith:moduleId moduleName:moduleName parameterList:parameterList iconImage:icon];
        [arrGameModule addObject:gameModule];
    }
    
    return arrGameModule;
}



+ (NSArray *)queryData:(NSString *)querySql {
    
    
    if (querySql == nil) {
        querySql = @"SELECT * FROM t_modals;";
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    FMResultSet *set = [_fmdb executeQuery:querySql];
    
    while ([set next]) {
        
        NSString *name = [set stringForColumn:@"name"];
        NSString *age = [set stringForColumn:@"age"];
        NSString *ID_No = [set stringForColumn:@"ID_No"];
        
        LVModal *modal = [LVModal modalWith:name age:age.intValue no:ID_No.intValue];
        [arrM addObject:modal];
    }
    return arrM;
}

+ (BOOL)deleteGameModuleByModuleId:(NSString *) moduleId{
    
     NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM t_gameModule WHERE moduleId = %@;", moduleId];
    
    return [_fmdb executeUpdate:deleteSql];
}


+ (BOOL)deleteData:(NSString *)deleteSql {
    
    if (deleteSql == nil) {
        deleteSql = @"DELETE FROM t_modals";
    }
    
    return [_fmdb executeUpdate:deleteSql];

}

+ (BOOL)modifyData:(NSString *)modifySql {
    
    if (modifySql == nil) {
        modifySql = @"UPDATE t_modals SET ID_No = '789789' WHERE name = 'lisi'";
    }
    return [_fmdb executeUpdate:modifySql];
}


+ (BOOL)modifyGameModuleByModuleId:(GameModule *)gameModule{
    
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE t_gameModule SET moduleName = %@, paraListValue = %@, icon = %@ WHERE moduleId = %@;", gameModule.moduleName, gameModule.parameterList, gameModule.icon, gameModule.moduleId];
    return [_fmdb executeUpdate:updateSql];
    
}



@end
