//
//  ViewController.m
//  AlipayQuickLogin
//
//  Created by ChenZhiWen on 9/26/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import "ViewController.h"
#import "AlipayQuickLogin.h"
@interface ViewController ()
@property (nonatomic,strong)UINavigationController *navVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goQuickLogin:(id)sender {
    AlipayQuickLogin *alipay = [[AlipayQuickLogin alloc]init];
    self.navVC = [[UINavigationController alloc]initWithRootViewController:alipay];
    alipay.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [self presentViewController:self.navVC animated:YES completion:NULL];
    __weak __typeof (&*alipay)weakAlipay = alipay;
    [alipay setSuccessBlock:^(NSDictionary *dic){
        NSLog(@"%@",[dic description]);
        [weakAlipay dismissViewControllerAnimated:YES completion:NULL];
    }];
}

- (void)back
{
    [self.navVC dismissViewControllerAnimated:YES completion:NULL];
}

@end
