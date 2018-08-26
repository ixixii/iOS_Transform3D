//
//  ViewController.m
//  17Transform3D
//
//  Created by beyond on 2018/1/2.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //[self transform3d_1];
    // [self transform3d_2];
    //[self transform3d_3];
    // [self transform3d_4];
    
    
    
    //[self transform3d_Y_1];
    //[self transform3d_Y_2];
    //[self transform3d_Y_3];
    [self transform3d_Y_4];
}
- (void)transform3d_1
{
    // 沿X轴,3d变换60度
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 1, 0, 0);
    _colorImgView.layer.transform = rotate;
}

- (void)transform3d_2
{
    // 下面3张图片,分别演示了相机距离图片锚点为40,80,160的情况
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 1, 0, 0);//角度代表倒下去的程度,即与竖直面的夹角,0度代表不倒下
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 160);// 40,80,160
}

// 有bug
- (void)transform3d_3
{
    // 如果要绕固定ImgeView的边(如底边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_colorImgView layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point:0.500000,0.500000
    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在底边中点
    [layer setAnchorPoint:CGPointMake(0.5, 1.0)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__187.000000,333.000000
    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__187.000000,453.000000
    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 1, 0, 0);
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 160);
}



- (void)transform3d_4
{
    // 如果要绕固定ImgeView的边(如底边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_colorImgView layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point:0.500000,0.500000
    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在底边中点
    [layer setAnchorPoint:CGPointMake(0.5, 1.0)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__187.000000,333.000000
    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__187.000000,453.000000
    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 1, 0, 0);
    
    // 由于上面整个图层向底边移动了,所以此时,这个相机位置的Y值,应该上移一段距离,到中心位置;240为图片的高
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, -240/2.0), 160);
}


#pragma mark - 公用方法
/*
 center指的是相机的位置，
 相机的位置是相对于要进行变换的CALayer的来说的，
 原点是CALayer的anchorPoint在整个CALayer的位置，
 例如CALayer的大小是(100, 200), anchorPoint值为(0.5, 0.5)，
 此时anchorPoint在整个CALayer中的位置就是(50, 100)，正中心的位置。
 传入透视变换的相机位置为(0, 0)，那么相机所在的位置相对于CALayer就是(50, 100)。
 
 如果希望相机在左上角，则需要传入(-50, -100)。
 
 disZ表示的是相机离z=0平面（也可以理解为屏幕）的距离。
 */


#pragma mark - 绕Y轴变换
- (void)transform3d_Y_1
{
    // 沿Y轴,3d变换60度
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 0, 1, 0);
    _colorImgView.layer.transform = rotate;
}
- (void)transform3d_Y_2
{
    // 下面3张图片,分别演示了相机距离图片锚点为40,80,160的情况
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 0, 1, 0);//角度代表倒下去的程度,即与竖直面的夹角,0度代表不倒下
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 160);// 40,80,160
}
// 有bug
- (void)transform3d_Y_3
{
    // 如果要绕固定ImgeView的边(如左边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_colorImgView layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point: 0.5  ,  0.5
    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在左边中点
    [layer setAnchorPoint:CGPointMake(0, 0.5)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__187.000000,333.000000
    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__67.000000,333.000000
    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 0, 1, 0);
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 160);// 这儿有bug
}

- (void)transform3d_Y_4
{// 如果要绕固定ImgeView的边(如底边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_colorImgView layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point:0.500000,0.500000
    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在左边中点
    [layer setAnchorPoint:CGPointMake(0, 0.5)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__187.000000,333.000000
    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__67.000000,333.000000
    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/3, 0, 1, 0);
    
    // 由于上面整个图层向左边移动了,所以此时,这个相机位置的X值,应该右移一段距离,到中心位置;240为图片的宽
    _colorImgView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(240/2.0, 0), 160);
}
- (IBAction)jumpToNextVCBtnClicked:(id)sender
{
    UIViewController *vc = [[NSClassFromString(@"SecondViewCtrl") alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - C方法
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
@end
