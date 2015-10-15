//
//  ViewController.m
//  BarrageView
//
//  Created by 李赛 on 15/10/15.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "ViewController.h"
#import "Barrage.h"
#import "BarrageView.h"

@interface ViewController ()

@property (nonatomic, strong) BarrageView *barrageView;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)postMyBarrage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.barrageView = [[BarrageView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200)];
    [self.view addSubview:self.barrageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    [self.barrageView postBarrage];
}

- (IBAction)stop:(id)sender {
    [self.barrageView stop];
}

- (IBAction)postMyBarrage:(id)sender {
    
    Barrage *barrage = [Barrage myBarrageWithText:@"这是我的弹幕!!~~~"];
    
    [self.barrageView postViewWithBarrage:barrage isMe:YES];
}
@end
