//
//  CommentCell.h
//  TableCommentDemo
//
//  Created by  iOSCXJ on 22/10/22.
//  Copyright © 2022年  iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface CommentCell : UITableViewCell
@property(nonatomic, strong)DetailModel * cellData;
@property(nonatomic ,assign)NSInteger index;

+ (CGFloat)cellHeight;

@end
