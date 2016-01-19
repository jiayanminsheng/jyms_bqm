//
//  BQMImageView.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/11.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "BQMImageView.h"

@interface BQMImageView()

@property(nonatomic, strong) id target;
@property(nonatomic) SEL action;

@end


@implementation BQMImageView

- (void)addTarget:(id)target action:(SEL)action{
    
    self.userInteractionEnabled = YES;
    self.target = target;
    self.action = action;
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
