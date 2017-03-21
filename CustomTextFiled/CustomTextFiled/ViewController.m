//
//  ViewController.m
//  CustomTextFiled
//
//  Created by Zs on 17/3/20.
//  Copyright © 2017年 Zs. All rights reserved.
//

#import "ViewController.h"
#import "CustomTF.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomTF *textField =[[CustomTF alloc] initWithFrame:CGRectMake(100, 100, 120, 44)];
    [textField addViewWithPlaceholder:@"请输入手机号"];
    [self.view addSubview:textField];
//    textField.backgroundColor =[UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
