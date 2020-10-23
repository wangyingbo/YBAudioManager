//
//  YBFilePathTool.h
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/22.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBFilePathTool : NSObject

#pragma mark - file

/// 根据文件夹名和文件名拼接路径
/// @param folderName 文件夹名
/// @param name 文件名，如果非空则会在后面拼接时间，如果为空则是时间；
+ (NSString *)filePathWithFolderName:(NSString * _Nullable )folderName fileName:(NSString * _Nullable )fileName;

+ (BOOL)saveData:(NSData *)data folderName:(NSString *)folderName fileName:(NSString *)fileName;

+ (NSData *)getDataWithPath:(NSString *)filePath;

+ (BOOL)existDataWithPath:(NSString *)filePath;

+ (BOOL)removeDataWithPath:(NSString *)filePath;

+ (BOOL)removeAllFilesWithFolderName:(NSString *)folderName;

@end

NS_ASSUME_NONNULL_END
