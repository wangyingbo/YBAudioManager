//
//  YBAVAudioPlayerTool.h
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/23.
//  Copyright © 2020 王颖博. All rights reserved.
//
//  播放本地音乐

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBAVAudioPlayerTool : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFileUrl:(NSURL *)fileUrl;

- (void)play;

- (void)stop;

- (BOOL)currentIsPlaying;

@end

NS_ASSUME_NONNULL_END
