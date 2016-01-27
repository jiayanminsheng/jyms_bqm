//
//  ProductViewController.h
//  01demo
//
//  Created by bqm on 16/1/26.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel2;
@property (weak, nonatomic) IBOutlet UITextField *num_unitTextField;
@property (weak, nonatomic) IBOutlet UILabel *num_unitLabel;
@property (weak, nonatomic) IBOutlet UITextField *price_unitTextField;
@property (weak, nonatomic) IBOutlet UILabel *price_unitLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeReleseButton;


@property (weak, nonatomic) IBOutlet UIButton *typeNameOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeNameTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *num_unitBtn;
@property (weak, nonatomic) IBOutlet UIButton *price_unitBtn;

@property (weak, nonatomic) IBOutlet UIButton *middleBtn;


@end
