//
//  YBFilePathTool.m
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/22.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import "YBFilePathTool.h"

@implementation YBFilePathTool


#pragma mark - file

+ (NSString *)filePathWithFolderName:(NSString *)folderName fileName:(NSString *)fileName {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSArray *nameArr = [fileName componentsSeparatedByString:@"/"];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:nameArr];
    [mutArr removeLastObject];
    NSString *preName = [mutArr componentsJoinedByString:@"/"];
    NSString *folderPath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,preName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    
    return filePath;
}

+ (BOOL)saveData:(NSData *)data folderName:(NSString *)folderName fileName:(NSString *)fileName {
    NSString *filePath = [self filePathWithFolderName:folderName fileName:fileName];
    return [data writeToFile:filePath atomically:YES];
}

+ (NSData *)getDataWithPath:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (BOOL)existDataWithPath:(NSString *)filePath {
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return isExist;
}

+ (BOOL)removeDataWithPath:(NSString *)filePath {
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeAllFilesWithFolderName:(NSString *)folderName {
    NSString *filePath = [self filePathWithFolderName:folderName fileName:nil];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
