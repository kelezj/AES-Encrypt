//
//  ViewController.m
//  AES Encrypt
//
//  Created by 张健 on 16/7/13.
//  Copyright © 2016年 ZJTechnology. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AES128.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"uuid=5B300CBD-28AD-4478-BEE6-861FAFEA943A&device=ios";
    // Base64
    NSString *encryptStr = [str aes128_encryptBase64WithKey:@"1234567890123456"];
    NSLog(@"加密后的结果(Base64)--%@",encryptStr);
    NSString *decryptStr = [encryptStr aes128_decryptBase64WithKey:@"1234567890123456"];
    NSLog(@"解密后的结果(Base64)--%@",decryptStr);
    // 16进制
    NSString *encryptStr16 = [str aes128_encryptH16WithKey:@"1234567890123456"];
    NSLog(@"加密后的结果(H16)--%@",encryptStr16);
    NSString *decryptStr16 = [encryptStr16 aes128_decryptH16WithKey:@"1234567890123456"];
    NSLog(@"解密后的结果(H16)--%@",decryptStr16);
    
    // 防篡改加密(Base64)
    NSString *highEncryptStr = [str aes128_encryptBase64WithKey:@"1234567890123456" length:12];
    NSLog(@"防篡改加密后的结果(Base64)--%@",highEncryptStr);
    // 模拟服务端验证
    NSString *highDecryptStr = [highEncryptStr aes128_decryptBase64WithKey:@"1234567890123456" length:12];
    if (highDecryptStr) {
        NSLog(@"防篡改解密后的结果(Base64)--%@",highDecryptStr);
    }else{
        NSLog(@"已篡改");
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
