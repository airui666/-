//
//  ViewController.m
//  test_32_弹性附着行为
//
//  Created by Apple on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "view1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    view1 *view=[[view1 alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
