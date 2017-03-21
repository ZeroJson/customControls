//
//  YCNotificationMessageView.m
//  YouChangCall
//
//  Created by Zs on 16/12/7.
//  Copyright © 2016年 HZJiTeng. All rights reserved.
//

#import "YCNotificationMessageView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface YCNotificationMessageView()
{
    NSTimer *timer;
    NSTimer *vibrateTimer;

}
@end
@implementation YCNotificationMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.frame =CGRectMake(0, -64, SCREEN_WIDTH, 64);
//        self.alpha =0.9;
        self.layer.shadowColor =[UIColor blackColor].CGColor;//阴影颜色
        self.layer.shadowOffset =CGSizeMake(0, 3);//x向右偏移0，y向下偏移3
        self.layer.shadowOpacity =0.1;//阴影透明度，默认0
        [UIView animateWithDuration:0.75 animations:^{
            self.frame =CGRectMake(0, 0, SCREEN_WIDTH, 64);
        }];
        [self addView];
        [self beginVibrate];
    }
    return self;
}

- (void)addView{
    
    UIImageView *messageImage =[[UIImageView alloc] init];
    [self addSubview:messageImage];
    CGFloat meaasgeLeft =0;
    meaasgeLeft =SCREEN_WIDTH*30/375;
    messageImage.frame =CGRectMake(10, 20, 20, 20);
    messageImage.image =IMAGE_NAME(@"message_icon_new");
    
    _messageLabel =[[UILabel alloc] init];
    [self addSubview:_messageLabel];
    _messageLabel.frame =CGRectMake(CGRectGetMaxX(messageImage.frame)+10, 10, 260, 16);
    _messageLabel.font =[UIFont systemFontOfSize:14];
    //    _messageLabel.text =@"这是一条消息";
    
    _contentLabel =[[UILabel alloc] init];
    [self addSubview:_contentLabel];
 
    _contentLabel.frame =CGRectMake(CGRectGetMaxX(messageImage.frame)+10, CGRectGetMaxY(_messageLabel.frame), SCREEN_WIDTH-40, 25);
    _contentLabel.font =[UIFont systemFontOfSize:11];
//    _contentLabel.numberOfLines =0;
    
    
    UIImageView *centerImage =[[UIImageView alloc] init];
    [self addSubview:centerImage];
    centerImage.frame =CGRectMake(SCREEN_WIDTH/2-20, 58, 40, 4);
    centerImage.image =IMAGE_NAME(@"message_btn_select");
    
    [self startTimer];//添加定时器
    
    //点击手势
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewCotre:)]];
    
    //拖动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:3.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0.75 animations:^{
            self.frame =CGRectMake(0, -64, SCREEN_WIDTH, 64);
        }];
        
    }];
}

- (void)endTimer {
    [timer invalidate];
    timer = nil;
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self];
    if (translation.y > 0) {
        translation.y = 0;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self endTimer];
            break;
            
        case UIGestureRecognizerStateChanged:
            recognizer.view.frame = CGRectMake(0, translation.y, SCREEN_WIDTH, recognizer.view.frame.size.height);
            
            break;
            
        case UIGestureRecognizerStateEnded:
            if (translation.y > -recognizer.view.frame.size.height/3) {
                [UIView animateWithDuration:0.168 animations:^{
                    recognizer.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, recognizer.view.frame.size.height);
                } completion:^(BOOL finished) {
                    [self startTimer];
                }];
            }else {
                [self removeSelf];
            }
            [recognizer setTranslation:CGPointZero inView:self];
            break;
            
        default:
            break;
    }
}

- (void)removeSelf {
    [UIView animateWithDuration:0.168 animations:^{
        self.frame = CGRectMake(0, -64, SCREEN_WIDTH, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**点击view的代理事件*/
/**
 *index：分类，服务器告诉是哪种类型的，具体跳转到那个页面
 *data_id：事件的id，用来页面详细数据的
 *taskId：推送消息的任务id,唯一标示透传任务id。
 */
- (void)addViewCotre:(UITapGestureRecognizer *)gesture{
    if ([_delegate respondsToSelector:@selector(didTopNotificationPushViewControllerWithInteger:withData_id:withTaskId:)]) {
        [self removeSelf];
        [_delegate didTopNotificationPushViewControllerWithInteger:self.index withData_id:self.data_id withTaskId:self.taskId];
    }
}

/**
 *震动设置
 */

//震动一下
- (void)beginVibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/*
///可控时间
- (void)vibration{
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,systemAudioCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);///开启震动
    vibrateTimer =  [NSTimer scheduledTimerWithTimeInterval:1.08 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self stopVibration];//关闭
    }];
}
void systemAudioCallback(){
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);///开启震动
}

- (void)stopVibration{
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);///关闭震动
    [vibrateTimer invalidate];///停止计时器
    
}

*/

@end
