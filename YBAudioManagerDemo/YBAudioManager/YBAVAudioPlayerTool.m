//
//  YBAVAudioPlayerTool.m
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/23.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import "YBAVAudioPlayerTool.h"
#import <AVFoundation/AVFoundation.h>

@interface YBAVAudioPlayerTool ()
@property(nonatomic,strong) AVAudioPlayer *player;
@property(nonatomic,assign) BOOL isPlaying;

@end

@implementation YBAVAudioPlayerTool

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"`-init` unavailable. Use `-initWithFolder:fileName:suffix:` instead"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithFileUrl:(NSURL *)fileUrl {
    if (self = [super init]) {
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        if (self.player) {
            [self.player prepareToPlay];
        }
        
        self.player.volume = 0.5;
        self.player.pan = -1;
        self.player.numberOfLoops = -1;
        self.player.rate = 0.5;
    }
    return self;
}

- (void)play {
    [self.player play];
    self.isPlaying = YES;
}

- (void)stop {
    [self.player stop];
    self.isPlaying = NO;
}

- (BOOL)currentIsPlaying {
    return self.isPlaying;
}

@end
