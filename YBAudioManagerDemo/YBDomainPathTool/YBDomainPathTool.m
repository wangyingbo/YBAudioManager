//
//  YBDomainPathTool.m
//  domainPathDemo
//
//  Created by fengbang on 2019/9/3.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "YBDomainPathTool.h"

@implementation YBDomainPathTool

+ (NSString *)folderName {
    return NSStringFromClass([self class]);
}

+ (NSString *)filePathWithName:(NSString *)name {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSArray *nameArr = [name componentsSeparatedByString:@"/"];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:nameArr];
    [mutArr removeLastObject];
    NSString *preName = [mutArr componentsJoinedByString:@"/"];
    NSString *folderPath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[self folderName],preName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[self folderName],name]];
    
    return filePath;
}

+ (BOOL)saveData:(NSData *)data name:(NSString *)name {
    NSString *filePath = [self filePathWithName:name];
    
    BOOL result =[data writeToFile:filePath atomically:YES];
    return result;
    
}

+ (NSData *)getDataWithName:(NSString *)name {
    NSString *filePath = [self filePathWithName:name];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (BOOL)exitDataWithName:(NSString *)name {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filePath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[self folderName],name]];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)removeDataWithName:(NSString *)name {
    NSString *filePath = [self filePathWithName:name];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeAllFiles {
    NSString *filePath = [self filePathWithName:@""];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
