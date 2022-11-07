//
//  CommentCell.m
//  TableCommentDemo
//
//  Created by  iOSCXJ on 22/10/22.
//  Copyright © 2022年  iOS1. All rights reserved.
//
#define ScreenWidth        [UIScreen mainScreen].bounds.size.width

#import "CommentCell.h"
#import "NSString+YTH.h"



@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
static CGFloat cellHeight = 0;

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
  [self initControl];
}


+ (CGFloat)cellHeight {
  return cellHeight;
}
-(void)initControl{
  _commentLabel.preferredMaxLayoutWidth = ScreenWidth-56-16-10; //20
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
  
}

-(void)setCellData:(DetailModel *)cellData{

  _cellData = cellData;
  _commentLabel.text = cellData.message;

//用autolayout算高
//  CGFloat layoutCellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//  cellHeight = layoutCellHeight;
    
//用内容算高
//  cellHeight = [self heightForString:cellData.message fontSize:15 andWidth:ScreenWidth-56-16-10]+14;
    
    CGFloat contentH = [_commentLabel.text heightWithFont:[UIFont systemFontOfSize:15] lineSpacing:0 fixedWithWidth:ScreenWidth-56-16-10] + 14;
    cellHeight = contentH;
  
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    
    CGSize sizeToFit =  [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
    
  return sizeToFit.height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
