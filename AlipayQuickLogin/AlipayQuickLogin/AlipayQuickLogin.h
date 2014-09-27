//
//  AlipayQuickLogin.h
//  AlipayQuickLogin
//
//  Created by ChenZhiWen on 9/26/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AlipayQuickLogin : UIViewController
typedef void (^authSuccessBlock)(NSDictionary*);
@property (copy,nonatomic) authSuccessBlock successBlock;
@end
