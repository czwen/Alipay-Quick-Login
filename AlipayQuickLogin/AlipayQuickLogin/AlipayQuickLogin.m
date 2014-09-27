//
//  AlipayQuickLogin.m
//  AlipayQuickLogin
//
//  Created by ChenZhiWen on 9/26/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import "AlipayQuickLogin.h"
#import "NSString+MD5.h"


#define ALIPAY_GATEWAY_URL @"https://mapi.alipay.com/gateway.do?"
#warning 填写必要信息⬇️
#define ALIPAY_PARTNER @""
#warning 填写必要信息⬇️
#define ALIPAY_KEY @""
#define ALIPAY_SERVICE @"alipay.auth.authorize"
#define ALIPAY_TARGET_SERVICE @"user.auth.quick.login"
#warning 填写必要信息⬇️
#define ALIPAY_LOGIN_RETURN_URL @""
#define ALIPAY_SIGN_TYPE @"MD5"
#define ALIPAY_INPUT_CHARSET @"utf-8"
@interface AlipayQuickLogin ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation AlipayQuickLogin

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self setupRequest];
}

- (void)setupRequest
{
    
    NSString *urlString = ALIPAY_GATEWAY_URL;
    
    NSMutableString *prepareSignString = [NSMutableString stringWithFormat:@"_input_charset=%@&partner=%@&return_url=%@&service=%@&target_service=%@%@",ALIPAY_INPUT_CHARSET,ALIPAY_PARTNER,ALIPAY_LOGIN_RETURN_URL,ALIPAY_SERVICE,ALIPAY_TARGET_SERVICE,ALIPAY_KEY];
    
    NSString *sign = [prepareSignString MD5];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"_input_charset=%@&partner=%@&return_url=%@&service=%@&sign=%@&target_service=%@&sign_type=%@",ALIPAY_INPUT_CHARSET,ALIPAY_PARTNER,ALIPAY_LOGIN_RETURN_URL,ALIPAY_SERVICE,sign,ALIPAY_TARGET_SERVICE,ALIPAY_SIGN_TYPE]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    if ([webView.request.URL.absoluteString hasPrefix:ALIPAY_LOGIN_RETURN_URL]) {
        [webView stopLoading];
        NSArray *urlComponents = [webView.request.URL.absoluteString componentsSeparatedByString:@"&"];
        NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *keyValuePair in urlComponents)
        {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents objectAtIndex:0];
            NSString *value = [[pairComponents objectAtIndex:1] stringByRemovingPercentEncoding];
            [queryStringDictionary setValue:value forKey:key];
        }
        if (self.successBlock) {
            self.successBlock(queryStringDictionary);
        }
        self.webView.delegate = nil;
        self.webView.delegate = self;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
