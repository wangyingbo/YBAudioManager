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

+ (NSString *)filePathWithFolderName:(NSString *)folderName fileName:(NSString *)name {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSArray *nameArr = [name componentsSeparatedByString:@"/"];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:nameArr];
    [mutArr removeLastObject];
    NSString *preName = [mutArr componentsJoinedByString:@"/"];
    NSString *folderPath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,preName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [[paths firstObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,name]];
    
    return filePath;
}

+ (NSData *)getDataWithPath:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (BOOL)existDataWithPath:(NSString *)filePath {
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!isExist) {
        NSArray *arr = [filePath componentsSeparatedByString:@"/"];
        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:arr];
        [mutArr removeLastObject];
        NSString *newFilePath = [mutArr componentsJoinedByString:@"/"];
        return [[NSFileManager defaultManager] fileExistsAtPath:newFilePath];
    }
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
