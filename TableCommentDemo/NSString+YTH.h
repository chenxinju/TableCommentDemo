//
//  NSString+YTH.h
//  ShortcuticonApp
//
//  Created by CXJ-Build on 2018/5/3.
//  Copyright © 2018年 TDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (YTH)

/**
 未知类型（仅限字典/数组/字符串）
 
 @param object 字典/数组/字符串
 @return 字符串
 */
+(NSString *) jsonStringWithObject:(id) object;

/**
 字典类型转JSON
 
 @param dictionary 字典数据
 @return 返回字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;


/**
 数组类型转JSON
 
 @param array 数组类型
 @return 返回字符串
 */
+(NSString *)jsonStringWithArray:(NSArray *)array;


/**
 字符串类型转JSON
 
 @param string 字符串类型
 @return 返回字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string;



//Json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转Json字符串
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict;

//对一个jsonz字符串进行base64编码
-(NSString *)base64EncodeJsonString:(NSString *)jsonString;

//对一个str进行base64编码
-(NSString *)base64EncodeString:(NSString *)string;
//解码
-(NSString *)base64DecodeString:(NSString *) string;

//图片转base64字符串
- (NSString  *)encodeToBase64String:(UIImage *)image;
//base64字符串转图片
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;


//遍历数组拼接换行符
+(NSString *)stitchinglineStringWithArray:(NSArray *)array;


//数组转成json串
+ (NSString *)toJsonStrWithArray:(NSArray *)arr;

/**
 判断NSString中是否有表情
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

//计算文字宽度
- (CGFloat)widthWithFont:(UIFont *)font fixedWithHeight:(CGFloat)height;

//计算文字高度
- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing fixedWithWidth:(CGFloat)width;

//计算文字宽高
- (CGSize )boundingRectWithSizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing fixedWithWidth:(CGFloat)width;



/// 时间戳转为字符显示
/// @param dateString 时间戳字符串
/// @param formate yyyy-MM-dd
- (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;


//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
- (long)changeTimeToTimeSp:(NSString *)timeStr format:(NSString *)format;

- (NSString *)MD5HashString;

//获取当前时间s
+ (NSString *)getNowTimeTimestamp;
@end
