//
//  NSString+YTH.m
//  ShortcuticonApp
//
//  Created by CXJ-Build on 2018/5/3.
//  Copyright © 2018年 TDP. All rights reserved.
//

#import "NSString+YTH.h"
#import "NSData+Extension.h"



@implementation NSString (YTH)

/**
 未知类型（仅限字典/数组/字符串）
 
 @param object 字典/数组/字符串
 @return 字符串
 */
+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

/**
 字符串类型转JSON
 
 @param string 字符串类型
 @return 返回字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string{
    
    NSString *strUrl =  [NSString stringWithFormat:@"%@",
                         [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]
                         ];
    return [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 数组类型转JSON
 
 @param array 数组类型
 @return 返回字符串
 */
+(NSString *)jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

/**
 字典类型转JSON
 
 @param dictionary 字典数据
 @return 返回字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//Json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转Json字符串
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//对一个jsonz字符串进行base64编码
-(NSString *)base64EncodeJsonString:(NSString *)jsonString {
    //1 str->data  字符串转为二进制数据
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //2 对二进制数据进行base64编码,完成后返回字符串
    return [jsonData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


//对一个str进行base64编码
-(NSString *)base64EncodeString:(NSString *)string {
    //1 str->data  字符串转为二进制数据
    NSData *data = [string dataUsingEncoding:kCFStringEncodingUTF8];
    //2 对二进制数据进行base64编码,完成后返回字符串
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
//解码
-(NSString *)base64DecodeString:(NSString *) string {
    //1 转换为二进制数据（注意：该字符串是base64编码后的字符）
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //2 把二进制数据转化为字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString  *)encodeToBase64String:(UIImage*)image {
    
    return [UIImageJPEGRepresentation(image,1.0) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
}

- (UIImage *)decodeBase64ToImage:(NSString*)strEncodeData {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
    
}


+(NSString *)stitchinglineStringWithArray:(NSArray *)array{
    
    NSMutableString *reString = [NSMutableString string];

    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = valueObj;
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@"\n"]];

    return reString;
}

+ (NSString *)toJsonStrWithArray:(NSArray *)arr {
    if ([arr isKindOfClass:[NSString class]]) {
        return (NSString *)arr;
    }
    NSError *parseError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (parseError) {
        jsonStr = @"";
    }
    return jsonStr;
}

/**
 判断NSString中是否有表情
 */
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                if (!(9312 <= hs && hs <= 9327)) { // 9312代表①   表示①至⑯
                    isEomji = YES;
                }
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

- (CGFloat)widthWithFont:(UIFont *)font fixedWithHeight:(CGFloat)height {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceil(rect.size.width);
}

- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing fixedWithWidth:(CGFloat)width {
    //清除收尾换行与空格
    NSString *title = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //    NSLog(@"计算的文本信息--------%@",title);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraphStyle setLineSpacing:lineSpacing];
    
    NSDictionary * attributes = @{
        NSFontAttributeName:font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGFloat textHeight = [title boundingRectWithSize:textRect
                                             options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                          attributes:attributes
                                             context:nil].size.height;
    return textHeight;
    
}

//计算文字宽高
- (CGSize )boundingRectWithSizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing fixedWithWidth:(CGFloat)width {
    
    //清除收尾换行与空格
    NSString *title = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //    NSLog(@"计算的文本信息--------%@",title);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraphStyle setLineSpacing:lineSpacing];
    
    NSDictionary * attributes = @{
        NSFontAttributeName:font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGSize textSize = [title boundingRectWithSize:textRect
                                             options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                          attributes:attributes
                                             context:nil].size;
    return textSize;
}

- (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
        //转换为时间戳
    NSTimeInterval afterTime = dateString.integerValue;
    NSDate *needFormatDate = [[NSDate alloc] initWithTimeIntervalSince1970:afterTime];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    NSString *dateStr = @"";
    
    [dateFormatter setDateFormat:formate];
    
    dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
    
    return dateStr;
}


//将yyyy-MM-dd 格式时间转换成时间戳
-(long)changeTimeToTimeSp:(NSString *)timeStr format:(NSString *)format
{
    long time;
    NSDateFormatter *newformat = [[NSDateFormatter alloc] init];
    [newformat setDateFormat:format]; //@"yyyy-MM-dd'T'HH:mm:ssZ"
    NSDate *fromdate= [newformat dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}


+ (NSString *)getNowTimeTimestamp { //获取当前时间s
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString * timeString = [NSString stringWithFormat:@"%0.f", a]; //转为字符型
    return timeString;
}


- (NSString *)MD5HashString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5HashString];
}




@end
