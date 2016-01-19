//
//  ReplyCell.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/18.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ReplyCell.h"

@implementation ReplyCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshHelpCellWithModel:(HelpModel *)model
{
    self.replyLabel.text=model.reply;
    //头像暂无
    self.userName.text=model.username;
    //时间
    NSArray *arr=[model.addtime componentsSeparatedByString:@" "];

    self.addTimeLabel.text=arr[0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
