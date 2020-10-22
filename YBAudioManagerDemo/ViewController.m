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


@interface ViewController ()
@property (nonatomic, strong) YBAudioManager *audioManager;
@end


#define FULL_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FULL_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configUI];
}

#pragma mark - initUI

- (void)configUI {
    CGFloat w = 150.f;
    CGFloat h = 50.f;
    UIColor *color = [UIColor colorWithRed:0.42 green:0.58 blue:0.98 alpha:1];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(FULL_SCREEN_WIDTH/2 - w/2, FULL_SCREEN_HEIGHT/2 - h/2, w, h)];
    [button setTitle:[NSString stringWithFormat:@"🍦🍰🍎"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = color;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self setLayerWithButton:button];
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(button.frame)+30, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame))];
    [deleteButton setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteButton.layer.cornerRadius = 5;
    deleteButton.backgroundColor = color;
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
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

#pragma mark - initData

- (YBAudioManager *)audioManager {
    if (!_audioManager) {
        YBAudioManager *audioManager = [[YBAudioManager alloc] initWithFolder:@"wangyingbo" fileName:nil suffix:nil];
        _audioManager = audioManager;
    }
    return _audioManager;
}

#pragma mark - actions

- (void)buttonClick:(UIButton *)sender {
    if (self.audioManager.currentIsRecording) {
        [self.audioManager stopRecord];
    }else {
        [self.audioManager startRecord];
    }
}

- (void)deleteButtonClick:(UIButton *)sender {
    NSLog(@"当前的录音文件路径:%@",self.audioManager.filePath);
    
    BOOL isexist = [YBFilePathTool existDataWithPath:self.audioManager.filePath];
    NSLog(@"是否存在：%@",isexist?@"yes":@"no");
    
    if (isexist) {
        BOOL deleteSuccess = [YBFilePathTool removeDataWithPath:self.audioManager.filePath];
        NSLog(@"删除成功：%@",deleteSuccess?@"yes":@"no");
    }
}

@end
