//
//  DetailModel.h
//  TableCommentDemo
//
//  Created by  iOSCXJ on 22/10/22.
//  Copyright © 2022年  iOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property(nonatomic ,strong)NSString * name;
@property(nonatomic ,strong)NSString * message;
@property(nonatomic ,strong)NSMutableArray *commentArray;
@property(nonatomic ,assign)float height;

@end
