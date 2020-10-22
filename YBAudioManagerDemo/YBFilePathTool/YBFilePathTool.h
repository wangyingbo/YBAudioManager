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

+ (NSString *)filePathWithFolderName:(NSString * _Nullable )folderName fileName:(NSString * _Nullable )name;

+ (NSData *)getDataWithPath:(NSString *)filePath;

+ (BOOL)existDataWithPath:(NSString *)filePath;

+ (BOOL)removeDataWithPath:(NSString *)filePath;

+ (BOOL)removeAllFilesWithFolderName:(NSString *)folderName;

@end

NS_ASSUME_NONNULL_END
