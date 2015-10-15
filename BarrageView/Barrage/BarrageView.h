//
//  BarrageView.h
//  BarrageView
//
//  Created by 李赛 on 15/10/8.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Barrage.h"

@interface BarrageView : UIView

@property (nonatomic, strong) UIButton *open;

- (void)postBarrage;

- (void)stop;

/// 发送单个弹幕
- (void)postViewWithBarrage:(Barrage *)barrage isMe:(BOOL)isMe;

- (void)postVIewWithTime:(NSInteger)time singleLine:(BOOL)singleLine;

@end
