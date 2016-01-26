//
//  BQMLabel.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/5.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "BQMLabel.h"

@implementation BQMLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame  bgColor:(UIColor *)bgcolor text:(NSString *)textStr textFont:(UIFont *)font textColor:(UIColor *)textcolor{
    if (self=[super init]) {
        self.frame=frame;
        self.backgroundColor=bgcolor;
        self.text=textStr;
        self.textColor=textcolor;
        self.font=font;
    }

    return self;
}

@end
