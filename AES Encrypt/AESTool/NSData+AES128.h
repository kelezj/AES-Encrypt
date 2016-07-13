//
//  NSData+AES128.h
//  AES Encrypt
//
//  Created by 张健 on 16/7/13.
//  Copyright © 2016年 ZJTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData(AES128)
-(NSData *) aes128_encrypt:(NSString *)key;
-(NSData *) aes128_decrypt:(NSString *)key;
@end

