//
//  Barrage.h
//  BarrageView
//
//  Created by 李赛 on 15/10/13.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Barrage : NSObject

@property (nonatomic, copy) NSString *pid;

/// 显示内容
@property (nonatomic, copy) NSString *content;

/// 时间
@property (nonatomic, assign) float time;

/// 点赞数
@property (nonatomic, assign) NSInteger up;

/// 头像链接
@property (nonatomic, copy) NSString *head;

/// 分数
@property (nonatomic, assign) float score;

/// 用户id
@property (nonatomic, copy) NSString *uid;


// 字典转模型

- (instancetype) initWithDic:(NSDictionary *) dic;

+ (instancetype) barrageWithDic:(NSDictionary *) dic;

//  我的弹幕
+ (instancetype) myBarrageWithText:(NSString *)text;

+ (NSArray *)barrageList;

@end
