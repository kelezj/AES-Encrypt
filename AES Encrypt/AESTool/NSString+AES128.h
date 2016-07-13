//
//  NSString+AES128.h
//  AES Encrypt
//
//  Created by 张健 on 16/7/13.
//  Copyright © 2016年 ZJTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSData+AES128.h"

@interface NSString(AES128)
/**
 *  加密（ECB 128位 PKCS7Padding补码 结果Base64编码输出）
 *
 *  @param key    秘钥
 *
 *  @return 加密后的字符串
 */
-(NSString *)aes128_encryptWithKey:(NSString *)key;

/**
 *  解密（ECB 128位 PKCS7Padding补码 Base64编码输出）
 *
 *  @param key    秘钥
 *
 *  @return 解密后的字符串
 */
-(NSString *)aes128_decryptWithKey:(NSString *)key;

/**
 *  加密（ECB 128位 PKCS7Padding补码 Base64编码输出）
 *
 *  @param key    秘钥
 *  @param length 防篡改验证长度
 *
 *  @return 加密后的字符串
 */
-(NSString *)aes128_encryptWithKey:(NSString *)key length:(NSInteger)length;

/**
 *  解密（ECB 128位 PKCS7Padding补码 Base64编码输出）
 *
 *  @param key    秘钥
 *  @param length 防篡改验证长度
 *
 *  @return 解密后的字符串
 */
-(NSString *)aes128_decryptWithKey:(NSString *)key length:(NSInteger)length;

@end
