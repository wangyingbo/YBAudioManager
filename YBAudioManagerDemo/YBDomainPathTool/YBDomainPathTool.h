//
//  YBDomainPathTool.h
//  domainPathDemo
//
//  Created by fengbang on 2019/9/3.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBDomainPathTool : NSObject

+ (NSString *)folderName;

+ (BOOL)saveData:(NSData *)data name:(NSString *)name;

+ (NSData *)getDataWithName:(NSString *)name;

+ (BOOL)exitDataWithName:(NSString *)name;

+ (BOOL)removeDataWithName:(NSString *)name;

+ (BOOL)removeAllFiles;

@end

NS_ASSUME_NONNULL_END
