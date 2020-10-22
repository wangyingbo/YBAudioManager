//
//  YBAudioManager.h
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/22.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBAudioManager : NSObject<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, copy, readonly) NSString *filePath;

- (instancetype)initWithFolder:(NSString * _Nullable )folder fileName:(NSString * _Nullable )fileName suffix:(NSString * _Nullable )suffix;

// set save path
//- (void)setupPathWithFolderName:(NSString  * _Nullable )folderName;

/// 设置文件后缀
/// @param suffix suffix description
//- (void)setupFileSuffix:(NSString * _Nullable )suffix;

/// 设置文件名字，默认是日期
/// @param fileName fileName description
//- (void)setupFileName:(NSString  * _Nullable )fileName;

// start recordd
- (void)startRecord;

// pause record
- (void)pauseRecord;

// continue record
- (void)continueRecord;

// stop record
- (void)stopRecord;

// get audio time
- (float)getAudioAllTime;

/// 当前是否在录音
- (BOOL)currentIsRecording;

@end

NS_ASSUME_NONNULL_END
