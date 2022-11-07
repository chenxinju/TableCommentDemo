//
//  DetailCell.m
//  TableCommentDemo
//
//  Created by  iOSCXJ on 22/10/22.
//  Copyright © 2022年  iOS1. All rights reserved.
//
#define ScreenWidth        [UIScreen mainScreen].bounds.size.width
#define ScreenHeight       [UIScreen mainScreen].bounds.size.height
#import "DetailCell.h"
#import "CommentCell.h"
#import "CommentModel.h"

#import "NSString+YTH.h"

@interface DetailCell ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *commentTableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
static CGFloat cellHeight = 1;

@implementation DetailCell

- (void)awakeFromNib {
  [self initControl];
}

+ (CGFloat)cellHeight {
  return cellHeight;
}
-(void)initControl{

  self.commentTableview.dataSource = self;
  self.commentTableview.delegate =self;
  self.commentTableview.scrollEnabled = NO;
  self.commentTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
}
-(void)setCellData:(DetailModel *)cellData{

  _cellData = cellData;
  _nameLabel.text = _cellData.name;
  _messageLabel.text = _cellData.message;
  _messageViewHeight.constant = 36+[self heightForString:_cellData.message fontSize:15 andWidth:ScreenWidth-40]+10;
  
  CGFloat  commentHeight=0;
  for (int i=0; i<_cellData.commentArray.count; i++) {
    CommentModel *cModel = [_cellData.commentArray objectAtIndex:i];
      
     CGFloat height = [cModel.message heightWithFont:[UIFont systemFontOfSize:15] lineSpacing:0 fixedWithWidth:ScreenWidth-56-16-10] + 14;
      
      //CGFloat height = [self heightForString:cModel.message fontSize:15 andWidth:ScreenWidth-56-16-10]+14;

      commentHeight += height;
  }
  
  _commentTableHeight.constant = commentHeight + 10;
  [self.contentView updateConstraintsIfNeeded];
  if (_cellData.height==0) {
    _cellData.height =[self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
    
  }
  
  cellHeight = _cellData.height;
  
  
}
#pragma mark - TableView data source
//两个tableview嵌套，父table放所有信息，子table放评论列表
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _cellData.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return [CommentCell cellHeight];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  CommentCell *cell = (CommentCell *) [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] lastObject];
  }
  cell.index = [indexPath row];
  cell.cellData = [_cellData.commentArray objectAtIndex:[indexPath row]];

  return cell;
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  if (self.sendBlock) {
    self.sendBlock(self.index);
  }
  
}
//用label模拟算高
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
 
    CGSize sizeToFit =  [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
    
  return sizeToFit.height;
}



@end
