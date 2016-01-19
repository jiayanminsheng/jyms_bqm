//
//  HelpCell.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/8.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "HelpAnswerCell.h"

@implementation HelpAnswerCell

-(void)refreshHelpCellWithModel:(HelpModel *)model
{
    self.questionLabel.text=model.questions;
    //头像暂无
    self.userNameLabel.text=model.username;
    //时间
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1=[dateFormatter dateFromString:model.addtime];
    NSDate *date2=[NSDate date];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    long temp;
    NSString *result=[[NSString alloc]init];
    if (time < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = time/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }

    self.releasetimeLabel.text=result;
    
    self.answercountLabel.text=[NSString stringWithFormat:@"%@",model.question_status];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
