//
//  Barrage.m
//  BarrageView
//
//  Created by 李赛 on 15/10/13.
//  Copyright © 2015年 精灵在线. All rights reserved.
//

#import "Barrage.h"

@implementation Barrage

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+ (instancetype)barrageWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

//  我的弹幕
+ (instancetype) myBarrageWithText:(NSString *)text {
    Barrage *barrage = [[Barrage alloc] init];
    barrage.up = 0;
    barrage.content = text;
    
    return barrage;
}

+ (NSArray *)barrageList{
     NSMutableArray *allDatas = [NSMutableArray array];
    
    NSArray *array = [NSArray arrayWithObjects:@"hello world",
                      @"66666666666666666666666",
                      @"哈哈",
                      @"阿什利打飞机就",
                      @"啊链接大佛i了拉风;SD卡菲利克斯将诶", nil];
    
    for (int i = 0; i < 300; ++i) {
        Barrage *barrage;
        for (NSString *title in array) {
            barrage = [[Barrage alloc] init];
            barrage.up = i * 14;
            barrage.content = title;
            barrage.time = i;
            [allDatas addObject:barrage];
        }
        if (i == 15) {
            for (int k = 0; k < 3; ++k) {
                for (NSString *title in array) {
                    barrage = [[Barrage alloc] init];
                    barrage.up = i * 14;
                    barrage.content = title;
                    barrage.time = i;
                    [allDatas addObject:barrage];
                }
            }
        }
    }
    
    return allDatas;
}

@end
