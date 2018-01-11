//
//  ViewController.m
//  SWRoundView
//
//  Created by iSongWei on 2018/1/11.
//  Copyright © 2018年 iSong. All rights reserved.
//

#import "ViewController.h"
#import "SWRoundView.h"

@interface ViewController ()

@property (nonatomic,strong) SWRoundView * view1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRoundView * view1 = [[SWRoundView alloc]initWithFrame:(CGRectMake(20, 50, 335, 335  ))];
    _view1 = view1;
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    _view1.percent = arc4random()%100/100.0;
    
}


@end
