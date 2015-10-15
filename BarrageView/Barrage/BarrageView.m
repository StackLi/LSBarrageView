//
//  BarrageView.m
//  BarrageView
//
//  Created by 李赛 on 15/10/8.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import "BarrageView.h"
#import "BarrageParticleView.h"
#import "UIView+Sizes.h"

#define ITEMTAG 154
#define kTIME 6
#define kTOPMARGIN 4

@interface BarrageView ()

@property (nonatomic, strong) CAEmitterLayer *heartsEmitter;

// 分隔线
@property (nonatomic, strong) UIView *lineView;

// <-- 数据 -- >
/// 全屏弹幕数据
@property (nonatomic, strong) NSMutableArray *allList;

/// 上一次的发送的数据索引
@property (nonatomic, assign) NSInteger lastTime;
@property (nonatomic, assign) int lastIndex;
@property (nonatomic, assign) long lastClickTime;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BarrageView
{
    NSTimer *_timer;
    NSInteger _curIndex;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setClipsToBounds:YES];
        // 添加手势识别
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        _curIndex = 0;
        // 添加粒子效果
        [self addDazzle];
    }
    return self;
}

/// 开始发送弹幕
- (void)postBarrage{
    if (self.allList && self.allList.count > 0) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(postView) userInfo:nil repeats:YES];
        }
    }
}

/// 停止发送弹幕
- (void)stop{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/// 根据时间发送弹幕  以秒为单位
- (void)postVIewWithTime:(NSInteger)time singleLine:(BOOL)singleLine{
    
    for (int i = 0; i < self.allList.count; ++i) {
        Barrage *barrage = self.allList[i];
        if (time < self.lastTime) {
            self.lastTime = 0;
            _curIndex = 0;
            [self.allList removeAllObjects];
        }
        if (barrage.time >= time && barrage.time < time + 1) {
            if ([self.allList containsObject:barrage]) continue;
            [self.allList addObject:barrage];
            [self postViewWithBarrage:nil isMe:NO];
            self.lastTime = time;
        }
        if (barrage.time > time + 1) {
            break;
        }
    }
}

#pragma mark 发送弹幕

-(void) postView{
    [self postViewWithBarrage:nil isMe:NO];
}

- (void)postViewWithBarrage:(Barrage *)barrage isMe:(BOOL)isMe{
    if (self.allList && self.allList.count > 0) {
        int indexPath = random()%(int)((self.frame.size.height)/ 35);
        
        while (indexPath == self.lastIndex) {
            indexPath = random()%(int)((self.frame.size.height)/ 35);
        }
        if (isMe) indexPath = 0;
        int rand = random() % 20;
        
        int top = indexPath * 35 + kTOPMARGIN + rand;
        
        self.lastIndex = indexPath;
        BarrageParticleView *item = [[BarrageParticleView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, top, 10, 25) isMe:isMe];
        
        Barrage *dBarrage = nil;
        if (barrage) {
            dBarrage = barrage;
        }else{
            if (self.allList.count > _curIndex) {
                dBarrage = self.allList[_curIndex];
                _curIndex++;
            }else {
                _curIndex = 0;
                dBarrage = self.allList[_curIndex];
                _curIndex++;
            }
        }
        
        item.itemIndex = _curIndex - 1;
        item.barrage = dBarrage;
        
        item.tag = indexPath + ITEMTAG;
        [self addSubview:item];
        
        CGFloat time = item.width / 30;
        
        [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
            item.left = -item.width;
        } completion:^(BOOL finished) {
            [item removeFromSuperview];
        }];
        [self.layer insertSublayer:self.heartsEmitter above:item.layer];
    }
}

#pragma mark - 手势
-(void)click:(UITapGestureRecognizer *)tapGesture {
    
    long nowTime = [[NSDate date] timeIntervalSince1970] * 10;
    if (nowTime < self.lastClickTime + 2) {
        return;
    }
    
    CGPoint touchPoint = [tapGesture locationInView:self];
    NSArray *array = self.subviews;
    for (int i = (int)array.count - 1; i >= 0; --i) {
        UIView *view = array[i];
        if ([view isKindOfClass:[BarrageParticleView class]]) {
            BarrageParticleView *barrageView = array[i];
            if ([barrageView.layer.presentationLayer hitTest:touchPoint]) {
                /// 如果已经赞过了   直接返回
                if (barrageView.isZan) return;
                /// 赞效果
                [barrageView zan];
                /// 粒子效果
                _heartsEmitter.emitterPosition = touchPoint;
                [self likeButtonPressed];
                /// 记录点击时间
                self.lastClickTime = nowTime;
                break;
            }
        }
    }
}

#pragma mark - 粒子效果 桃心
- (void)addDazzle{
    // Configure the emitter cell
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    
    heart.emissionLongitude = -M_PI; // up
    heart.emissionRange = M_PI / 3;  // in a wide spread
    heart.birthRate		= 0.0;			// emitter is deactivated for now
    heart.lifetime		= 4.0;			// 生命周期 粒子存在时间
    
    heart.velocity		= -20;			// 速度
    heart.velocityRange = 20;			// 速度范围
    heart.yAcceleration = 0;			// but fall eventually
    
    heart.contents		= (id) [[UIImage imageNamed:@"love_fly"] CGImage];
    heart.color			= [[UIColor colorWithRed:1 green:0.0 blue:0.0 alpha:0.7] CGColor];
    heart.redRange		= 0;			// some variation in the color
    heart.blueRange		= 0;
    heart.greenRange    = 0;
    heart.alphaSpeed	= -0.5 / heart.lifetime;  // fade over the lifetime
    
    heart.scale			= 0.5;			// let them start small
    heart.scaleSpeed	= 0;			// but then 'explode' in size
    heart.spinRange		= 0.3 * M_PI;	// and send them spinning from -180 to +180 deg/s
    
    // Add everything to our backing layer
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
}

- (CAEmitterLayer *)heartsEmitter{
    if (!_heartsEmitter) {
        _heartsEmitter = [CAEmitterLayer layer];
        _heartsEmitter.emitterSize = CGSizeMake(24, 24);
        
        // Spawn points for the hearts are within the area defined by the button frame
        _heartsEmitter.emitterMode	= kCAEmitterLayerOutline;
        _heartsEmitter.emitterShape	= kCAEmitterLayerLine;
        _heartsEmitter.renderMode = kCAEmitterLayerAdditive;
        
    }
    return _heartsEmitter;
}

- (void)likeButtonPressed
{
    // Fires up some hearts to rain on the view
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:2.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:0.0];
    heartsBurst.duration		= 0.1;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}

- (void)dealloc{
    [self.heartsEmitter removeFromSuperlayer];
    self.heartsEmitter = nil;
}

#pragma mark - (按钮,分隔线)跟随单行显示 或者隐藏
- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    self.lineView.hidden = hidden;
    self.open.hidden = hidden;
}

#pragma mark 懒加载

- (NSMutableArray *)allList{
    if (!_allList) {
        _allList = [NSMutableArray array];
        _allList = [Barrage barrageList].copy;
    }
    return _allList;
}

@end
