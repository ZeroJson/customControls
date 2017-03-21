//
//  CustomTF.m
//  CustomTextFiled
//
//  Created by Zs on 17/3/20.
//  Copyright © 2017年 Zs. All rights reserved.
//

#import "CustomTF.h"

@interface CustomTF ()<UITextFieldDelegate>{
    UILabel *placeholderLab;
}

@end

@implementation CustomTF

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
//        [self addView];
    }
    return self;
}

- (void)addViewWithPlaceholder:(NSString *)placeholder{
    self.backgroundColor =[UIColor redColor];
    UITextField *textField =[[UITextField alloc] init];
//    textField.backgroundColor =[UIColor orangeColor];
    textField.frame =CGRectMake(0, 10, self.frame.size.width, 40);
    [self addSubview:textField];
    textField.delegate =self;
    textField.backgroundColor =[UIColor orangeColor];
    textField.borderStyle =UITextBorderStyleNone;
    textField.font =[UIFont systemFontOfSize:16];
    
    
    placeholderLab =[[UILabel alloc] init];
    placeholderLab.frame =CGRectMake(0, 12, CGRectGetWidth(textField.frame), 38);
    placeholderLab.text =placeholder;
    placeholderLab.font =[UIFont systemFontOfSize:16.f  ];
    placeholderLab.textColor =[UIColor colorWithWhite:0.7 alpha:0.7];
    [textField addSubview:placeholderLab];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        placeholderLab.frame =CGRectMake(0, -5, CGRectGetWidth(textField.frame), 25);
        placeholderLab.font =[UIFont systemFontOfSize:14];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        placeholderLab.frame =CGRectMake(0, 12,self.frame.size.width, 38);
        placeholderLab.font =[UIFont systemFontOfSize:16.f  ];
    }];

    return [textField resignFirstResponder];
}

@end
