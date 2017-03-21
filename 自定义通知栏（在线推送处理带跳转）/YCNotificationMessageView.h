//
//  YCNotificationMessageView.h
//  YouChangCall
//
//  Created by Zs on 16/12/7.
//  Copyright © 2016年 HZJiTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
///自定义通知栏
@protocol YCNotificationMessageView <NSObject>
- (void)didTopNotificationPushViewControllerWithInteger:(NSInteger )index withData_id:(NSString *)data_id withTaskId:(NSString *)taskId;
@end

@interface YCNotificationMessageView : UIWindow

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) NSInteger index;///跳转的那个页面
@property (nonatomic, strong) NSString *data_id;///跳转后发送请求的id号
@property (nonatomic, strong) NSString *taskId;///推送消息的任务id,唯一标示透传任务id。
@property (nonatomic, weak) id<YCNotificationMessageView>delegate;

@end
