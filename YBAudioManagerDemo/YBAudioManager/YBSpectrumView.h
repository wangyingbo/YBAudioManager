//
//  YBSpectrumView.h
//  YBAudioManagerDemo
//
//  Created by fengbang on 2020/10/23.
//  Copyright © 2020 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBSpectrumView;

NS_ASSUME_NONNULL_BEGIN

@interface YBSpectrumView : UIView

@property (nonatomic, copy) void (^itemLevelCallback)(void);

//

@property (nonatomic) NSUInteger numberOfItems;

@property (nonatomic) UIColor * itemColor;

@property (nonatomic) CGFloat level;

@property (nonatomic) UILabel *timeLabel;

@property (nonatomic) NSString *text;

@property (nonatomic) CGFloat middleInterval;

- (void)start;
- (void)stop;


@end

NS_ASSUME_NONNULL_END
