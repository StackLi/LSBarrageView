//
//  BarrageParticleView.m
//  BarrageView
//
//  Created by 李赛 on 15/10/9.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import "BarrageParticleView.h"
#import "UIView+Sizes.h"

#define kMARGIN 8

@interface BarrageParticleView ()
@property (nonatomic, strong) UIImageView *imageView;

/// 头像
@property (nonatomic, strong) UIImageView *iconView;

/// 是否自己发送
@property (nonatomic, assign) BOOL isMe;

@end

@implementation BarrageParticleView

- (id)initWithFrame:(CGRect)frame isMe:(BOOL)isMe {
    if (self = [super initWithFrame:frame]) {
        self.isMe = isMe;
        [self createViews];
    }
    return self;
}

/// 点赞
- (void)zan{
    self.detailed.textColor = [UIColor redColor];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"love_zan"] forState:UIControlStateNormal];
    self.barrage.up += 1;
    [self.button setTitle:[NSString stringWithFormat:@" %ld",(long)self.barrage.up] forState:UIControlStateNormal];
    // 更新frame
    [self updateFrame];
    
    self.isZan = YES;
    /// 和服务器进行同步
}

- (void)setBarrage:(Barrage *)barrage{
    _barrage = barrage;
    [_detailed setText:barrage.content];
    [_detailed sizeToFit];
    
    if (barrage.up > 0) {
        [_button setTitle:[NSString stringWithFormat:@" %ld",(long)barrage.up] forState:UIControlStateNormal];
    }
    
    [self updateFrame];
}

- (void)updateFrame{
    [_button sizeToFit];
    // 更新views的frame
    if (self.isMe) {
        _iconView.image = [UIImage imageNamed:@"defaultUserIcon"];
        /// <-- 图片可以用网络图片加载 -->
        
        self.width = _detailed.width + 4 * kMARGIN + _button.width + 42;
        self.detailed.left = 42;
        _imageView.frame = CGRectMake(38, 0, self.width - 42, self.height);
    }else{
        self.width = _detailed.width + 4 * kMARGIN + _button.width;
        _imageView.frame = self.bounds;
    }
    _button.left = self.width - _button.width - kMARGIN;
    _lineView.left = self.width - _button.width - 2 * kMARGIN;
    _button.top = (self.height - _button.height) / 2.0;
    _detailed.top = (self.height - _detailed.height) / 2.0;
}

- (void)createViews{
    _detailed = [[UILabel alloc] initWithFrame:CGRectMake(kMARGIN, 0, 0, self.height)];
    _detailed.font = [UIFont systemFontOfSize:12];
    _detailed.textColor = [UIColor grayColor];
    _detailed.textAlignment = NSTextAlignmentCenter;
    
    _button = [[UIButton alloc] init];
    [_button setImage:[UIImage imageNamed:@"love_default"] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 0.5, 20)];
    _lineView.image = [UIImage imageNamed:@"love_line"];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    // 如果是自己发的
    if (self.isMe) {
        UIImage *image = [UIImage imageNamed:@"barrage_background_me"];
        
        image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        self.imageView.image = image;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(4, -2.5, 30, 30)];
        _iconView.layer.cornerRadius = 15;
        _iconView.layer.masksToBounds = YES;
        [self addSubview:_iconView];
    }else{
        UIImage *image = [UIImage imageNamed:@"barrage_background"];
        
        image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        _imageView.image = image;
    }
    
    [self addSubview:_detailed];
    [self addSubview:_lineView];
    [self addSubview:_button];
    [self insertSubview:_imageView atIndex:0];
}

@end
