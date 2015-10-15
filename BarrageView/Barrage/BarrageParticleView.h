//
//  BarrageParticleView.h
//  BarrageView
//
//  Created by 李赛 on 15/10/9.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Barrage.h"

@interface BarrageParticleView : UIView

/// 信息
@property (retain, nonatomic) UILabel *detailed;
/// 分割线
@property (retain, nonatomic) UIImageView *lineView;
/// 点赞按钮
@property (retain, nonatomic) UIButton *button;

@property (assign, nonatomic) NSInteger itemIndex;

@property (nonatomic, strong) Barrage *barrage;

/// 是否赞过
@property (nonatomic, assign) BOOL isZan;

- (id)initWithFrame:(CGRect)frame isMe:(BOOL)isMe;

- (void)zan;
@end
