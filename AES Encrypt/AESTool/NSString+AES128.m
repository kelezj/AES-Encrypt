//
//  NSString+AES128.m
//  AES Encrypt
//
//  Created by 张健 on 16/7/13.
//  Copyright © 2016年 ZJTechnology. All rights reserved.
//

#import "NSString+AES128.h"

@implementation NSString (AES128)
// 加密
- (NSString *)aes128_encryptWithKey:(NSString *)key{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data aes128_encrypt:key];
    
    // 输出格式根据服务端要求（16进制编码/Base64编码）
    
//    // 16进制输出
//    if (result && result.length > 0) {
//        Byte *datas = (Byte*)[result bytes];
//        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
//        for(int i = 0; i < result.length; i++){
//            [output appendFormat:@"%02x", datas[i]];
//        }
//        return output;
//    }
    
    // Base64编码输出
    if (result && result.length > 0) {
        NSString *output = [result base64EncodedStringWithOptions:0];
        return output;
    }
    return nil;
}

// 解密
- (NSString *)aes128_decryptWithKey:(NSString *)key{
    // 根据加密的编码方式
    
    // 16进制
    //    NSMutableData *data = [NSMutableData dataWithCapacity:self.length/2];
    //    unsigned char whole_byte;
    //    char byte_chars[3] = {'\0','\0','\0'};
    //    int i;
    //    for (i=0; i < [self length] / 2; i++) {
    //        byte_chars[0] = [self characterAtIndex:i*2];
    //        byte_chars[1] = [self characterAtIndex:i*2+1];
    //        whole_byte = strtol(byte_chars, NULL, 16);
    //        [data appendBytes:&whole_byte length:1];
    //    }
    
    // Base64
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    //对数据进行解密
    NSData *result = [decodeData aes128_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

// 防篡改加密
- (NSString *)aes128_encryptWithKey:(NSString *)key length:(NSInteger)length{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data aes128_encrypt:key];
    
    // Base64编码
    if (result && result.length > 0) {
        NSString *base64Str = [result base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        // 待MD5加密的拼接字符串（base64编码结果+key）
        NSString *allStr = [base64Str stringByAppendingString:key];
        // MD5加密
        NSString *md5Str = [allStr md5String];
        // 截取特定长度用作篡改校验
        NSString *checkStr = [md5Str substringToIndex:length];
        // 拼接输出结果（校验串+base64编码结果）
        return [checkStr stringByAppendingString:base64Str];
    }
    
    return nil;
}

// 防篡改解密
- (NSString *)aes128_decryptWithKey:(NSString *)key length:(NSInteger)length{
    // 截取返回的校验符
    NSString *checkStr1 = [self substringToIndex:length];
    // 截取base64
    NSString *base64Str = [self substringFromIndex:length];
    // 待MD5加密的拼接字符串（base64编码结果+key）
    NSString *allStr = [base64Str stringByAppendingString:key];
    // MD5加密
    NSString *md5Str = [allStr md5String];
    // 截取篡改校验符
    NSString *checkStr2 = [md5Str substringToIndex:length];
    // 对比是否篡改
    if ([checkStr1 isEqualToString:checkStr2]) {
        NSLog(@"未篡改");
    }else{
        NSLog(@"已篡改");
    }
    
    // Base64
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:base64Str options:0];
    //对数据进行解密
    NSData *result = [decodeData aes128_decrypt:key];
    
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

// MD5加密
- (NSString *)md5String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}
@end
