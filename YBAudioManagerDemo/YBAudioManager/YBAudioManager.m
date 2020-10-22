//
//  YBAudioManager.m
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/22.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import "YBAudioManager.h"
#import "YBFilePathTool.h"

#define AudioType @"mp3"

@interface YBAudioManager ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, copy) NSURL *recordFileUrl;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *folderName;
@property (nonatomic, copy) NSString *suffix;
@property (nonatomic, copy) NSString *fileName;
@end

@implementation YBAudioManager

- (instancetype)initWithFolder:(NSString *)folder fileName:(NSString *)fileName suffix:(NSString *)suffix {
    if (self = [super init]) {
        [self setupPathWithFolderName:folder];
        [self setupFileName:fileName];
        [self setupFileSuffix:suffix];
        [self configFilePath];
    }
    return self;
}

- (void)setupPathWithFolderName:(NSString *)folderName {
    self.folderName = folderName;
}

- (void)setupFileName:(NSString *)fileName {
    self.fileName = fileName;
}

- (void)setupFileSuffix:(NSString *)suffix {
    self.suffix = suffix;
}

- (NSString *)configFilePath {

//    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
//    NSString *timeStampStr = [NSString stringWithFormat:@"%.f",timeStamp];
        
    NSString *leveFolder = (self.folderName?self.folderName:@"");
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        
        NSString *filePath = [YBFilePathTool filePathWithFolderName:leveFolder fileName:[NSString stringWithFormat:@"%@%@.%@",(self.fileName.length>0?[self.fileName stringByAppendingString:@"_"]:@""),dateStr,(self.suffix.length>0?self.suffix:AudioType)]];
        //采用fileUrlWithPath 否则取不到语音时长
        self.recordFileUrl = [NSURL fileURLWithPath:filePath];
        self.filePath = filePath;
        NSLog(@"录音文件保存地址------->%@",self.filePath);
        return filePath;
}

- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        AVAudioSession *sessionTemp =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [sessionTemp setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if (sessionTemp == nil) {
            NSLog(@"Error creating session: %@",[sessionError description]);
            return nil;
        }else{
            [sessionTemp setActive:YES error:nil];
        }
        self.session = sessionTemp;
        //创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _recorder = [[AVAudioRecorder alloc]initWithURL:self.recordFileUrl settings:setting error:&error];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
        NSLog(@"recorder 创建完成:%@",self.recordFileUrl);
        [_recorder prepareToRecord];
        NSLog(@"recorder prepare");
    }
    return _recorder;
    
}

- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //采样率  8000/11025/22050/44100/96000（影响音频的质量）
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    // 编码格式
    [dicM setObject:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    // 录音质量
    [dicM setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    // 每个采样点位
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    // 浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    
    return dicM;
}

- (void)startRecord {
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        [self.recorder record];
    } else {
        [self.recorder record];
    }
}

- (void)pauseRecord {
    if ([self.recorder isRecording]) {
        [self.recorder pause];
    }
}

- (void)continueRecord {
    [self startRecord];
}

- (void)stopRecord {
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self.filePath]) {
        NSLog(@"文件大小为：%.2llukb", [[manager attributesOfItemAtPath:self.filePath error:nil] fileSize]/1024);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"文件时长为：%.f", [self getAudioAllTime]);
    });
}

// get audio time
- (float)getAudioAllTime {
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:self.recordFileUrl options:nil];
    CMTime duration = audioAsset.duration;
    NSInteger resultTime = 0;
    resultTime = CMTimeGetSeconds(duration);
    return resultTime;
}

- (BOOL)currentIsRecording {
    return self.recorder.isRecording;
}

@end
