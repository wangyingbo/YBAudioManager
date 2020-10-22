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


// set save path
- (NSString *)setupPathWithFolderName:(NSString *)folderName;
 
// start recordd
- (void)startRecord;
 
// pause record
- (void)pauseRecord;
 
// continue record
- (void)continueRecordd;
 
// stop record
- (void)stopRecord;
 
// get audio time
- (float)getAudioAllTime;

@end

NS_ASSUME_NONNULL_END
