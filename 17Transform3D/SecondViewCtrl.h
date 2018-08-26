//
//  SecondViewCtrl.h
//  17Transform3D
//
//  Created by beyond on 2018/1/2.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
- (IBAction)backBtnClicked:(id)sender;

@end
