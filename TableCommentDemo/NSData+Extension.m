//
//  NSData+Extension.m
//  FOLLApp
//
//  Created by XJdeveloperMini on 2020/1/9.
//  Copyright © 2020 XJdeveloper. All rights reserved.
//

#import "NSData+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Extension)


- (NSString *)MD5HashString
{
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  CC_MD5([self bytes], (CC_LONG)[self length], result);
  
  NSString *TDPt = @"%02x%02x%02x%02x%02x%02x%02x%02x"
                  @"%02x%02x%02x%02x%02x%02x%02x%02x";
  
  return [[NSString alloc] initWithFormat:TDPt,
          result[ 0], result[ 1], result[ 2], result[ 3],
          result[ 4], result[ 5], result[ 6], result[ 7],
          result[ 8], result[ 9], result[10], result[11],
          result[12], result[13], result[14], result[15]];
}

@end
