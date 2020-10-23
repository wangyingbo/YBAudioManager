//
//  ViewController.m
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/22.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "YBAudioManager.h"
#import "YBFilePathTool.h"
#import "YBSpectrumView.h"
#import "YBAVAudioPlayerTool.h"

@interface ViewController ()
@property (nonatomic, strong) YBAudioManager *audioManager;
@property (nonatomic, strong) YBSpectrumView *spectrumView;
@property (nonatomic, strong) YBAVAudioPlayerTool *audioPlayerTool;
@end


#define FULL_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FULL_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self configSpectrumView];
}

#pragma mark - initUI

- (void)configUI {
    CGFloat w = 150.f;
    CGFloat h = 50.f;
    UIColor *color = [UIColor colorWithRed:0.42 green:0.58 blue:0.98 alpha:1];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(FULL_SCREEN_WIDTH/2 - w/2, FULL_SCREEN_HEIGHT/2 - h/2, w, h)];
    [button setTitle:[NSString stringWithFormat:@"开始录制"] forState:UIControlStateNormal];//🍦🍰🍎
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = color;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self setLayerWithButton:button];
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - w/2 - w - 15, CGRectGetMaxY(button.frame)+30, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame))];
    [deleteButton setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteButton.layer.cornerRadius = 5;
    deleteButton.backgroundColor = color;
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    [self setLayerWithButton:deleteButton];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - w/2 + 15, CGRectGetMaxY(button.frame)+30, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame))];
    [playButton setTitle:[NSString stringWithFormat:@"播放"] forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    playButton.layer.cornerRadius = 5;
    playButton.backgroundColor = color;
    [playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    [self setLayerWithButton:playButton];
}

- (void)setLayerWithButton:(UIView *)view {
    CALayer *layer = view.layer;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 10.);
    layer.shadowRadius = 6.0;
    layer.shadowOpacity = 0.3;
    CGFloat shadowWidth = layer.bounds.size.width * 0.9;
    CGRect shadowRect = CGRectMake((0 + (layer.bounds.size.width - shadowWidth) / 2.0), 0, shadowWidth, layer.bounds.size.height);
    layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowRect].CGPath;
    layer.zPosition = 2;
}

- (YBSpectrumView *)spectrumView {
    if (!_spectrumView) {
        CGFloat spectrumView_w = 200.f;
        YBSpectrumView *spectrumView = [[YBSpectrumView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-spectrumView_w/2,120,spectrumView_w, 40.0)];
        [self.view addSubview:spectrumView];
        _spectrumView = spectrumView;
    }
    return _spectrumView;
}

- (void)configSpectrumView {
    [self.spectrumView class];
    self.spectrumView.text = [NSString stringWithFormat:@"%@",@"01:12:38"];
    __weak typeof(self)weakSelf = self;
    self.spectrumView.itemLevelCallback = ^(YBSpectrumView *spectrumView) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.audioManager updateMeters];
        //取得第一个通道的音频，音频强度范围是-160到0
        float power= [strongSelf.audioManager averagePowerForChannel:0];
        spectrumView.level = power;
    };
}

#pragma mark - initData

- (YBAudioManager *)audioManager {
    if (!_audioManager) {
        YBAudioManager *audioManager = [[YBAudioManager alloc] initWithFolder:@"wangyingbo/ios" fileName:@"fengbang/custom" suffix:nil];
        _audioManager = audioManager;
    }
    return _audioManager;
}

#pragma mark - actions

- (void)buttonClick:(UIButton *)sender {
    if (self.audioManager.currentIsRecording) {
        [self.audioManager stopRecord];
        [self.spectrumView stop];
        
        [sender setTitle:[NSString stringWithFormat:@"开始录制"] forState:UIControlStateNormal];
    }else {
        self.audioManager = nil;
        [self.audioManager startRecord];
        [self.spectrumView start];
        
        [sender setTitle:[NSString stringWithFormat:@"暂定录制"] forState:UIControlStateNormal];
    }
}

- (void)deleteButtonClick:(UIButton *)sender {
    NSLog(@"当前的录音文件路径:%@",self.audioManager.filePath);
    
    BOOL isexist = [YBFilePathTool existDataWithPath:self.audioManager.filePath];
    NSLog(@"是否存在：%@",isexist?@"yes":@"no");
    [YBFilePathTool removeAllFilesWithFolderName:@"wangyingbo"];
    if (isexist) {
        BOOL deleteSuccess = [YBFilePathTool removeDataWithPath:self.audioManager.filePath];
        NSLog(@"删除成功：%@",deleteSuccess?@"yes":@"no");
    }
}

- (void)playButtonClick:(UIButton *)sender {
    
    if (!_audioPlayerTool) {
        _audioPlayerTool = [[YBAVAudioPlayerTool alloc] initWithFileUrl:[NSURL fileURLWithPath:self.audioManager.filePath]];
    }
    
    if (![self.audioPlayerTool currentIsPlaying]) {
        [self.audioPlayerTool play];
        [sender setTitle:[NSString stringWithFormat:@"暂定播放"] forState:UIControlStateNormal];
    }else {
        [self.audioPlayerTool stop];
        [sender setTitle:[NSString stringWithFormat:@"开始播放"] forState:UIControlStateNormal];
    }
}

@end
