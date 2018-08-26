//
//  SecondViewCtrl.m
//  17Transform3D
//
//  Created by beyond on 2018/1/2.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import "SecondViewCtrl.h"

@interface SecondViewCtrl ()
{
    CGFloat numeratorView1;//view1变换时的分母,从2到180; 当180时,为0不透视;默认是PI/6
    CGFloat numeratorView2;//view2变换时的分母,从-2到-180; 当-180时,为0不透视;默认是PI/-180
}
@end

@implementation SecondViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    numeratorView1 = 6;
    numeratorView2 = -180;
    [self transform3d_view1_angle:M_PI/numeratorView1];
    
//    _view2.hidden = YES;
    
    
    
    
    [self transform3d_view3];
//    _view3.hidden = YES;
    
    
    
    [self addPanGuestureReco];
    
    
    [self.view bringSubviewToFront:_view1];
}
//
//#pragma mark - 公用方法
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
CATransform3D CATransform3DMakePerspective2(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
CATransform3D CATransform3DPerspect2(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective2(center, disZ));
}



//#pragma mark - view的变形
- (void)transform3d_view1_angle:(CGFloat )angle
{// 如果要绕固定ImgeView的边(如底边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_view1 layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point:0.500000,0.500000
//    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在左边中点
    [layer setAnchorPoint:CGPointMake(0, 0.5)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__87.500000,333.500000
//    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__27.500000,333.500000
//    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    
    // 由于上面整个图层向左边移动了,所以此时,这个相机位置的X值,应该右移一段距离,到中心位置;240为图片的宽
    _view1.layer.transform = CATransform3DPerspect2(rotate, CGPointMake(200/2.0, 0), 160);
}

//#pragma mark - view的变形
- (void)transform3d_view3
{// 如果要绕固定ImgeView的边(如底边)旋转，只需要调整 layer 的 anchorPoint 到对应的边上就行了
    CALayer *layer = [_view3 layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // sg__old anchor point:0.500000,0.500000
//    NSLog(@"sg__old anchor point:%f,%f",oldAnchorPoint.x,oldAnchorPoint.y);
    
    // 向下,向右 为正;此时锚点在左边中点
    [layer setAnchorPoint:CGPointMake(1, 0.5)];
    
    // 根据新旧锚点,移动图层的坐标位置
    // sg__layer pos old__87.500000,333.500000
//    NSLog(@"sg__layer pos old__%f,%f",layer.position.x,layer.position.y);
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    // sg__layer pos new__27.500000,333.500000
//    NSLog(@"sg__layer pos new__%f,%f",posX,posY);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(-M_PI/6, 0, 1, 0);
    
    // 由于上面整个图层向右边移动了,所以此时,这个相机位置的X值,应该左移一段距离,到中心位置;240为图片的宽
    _view3.layer.transform = CATransform3DPerspect2(rotate, CGPointMake(-200/2.0, 0), 160);
}



#pragma mark - 触摸





- (void)addPanGuestureReco
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:pan];
}
- (void)panView:(UIPanGestureRecognizer *)pan
{
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: // 开始触发手势
            
            break;
            
        case UIGestureRecognizerStateEnded: // 手势结束
            
            break;
            
        default:
            break;
    }
    
    // 1.在view上面挪动的距离
    CGPoint translation = [pan translationInView:pan.view];
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
//    NSLog(@"sg___x:%f",translation.x);
    NSLog(@"sg__numeratorView_1:%f",numeratorView1);
    NSLog(@"sg__numeratorView___________2:%f",numeratorView2);
    // 2.清空移动的距离
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
    // 根据位置translationX 设置view1透视的角度 变换
    [self view1_AnimationWithTranslationX:translation.x];
    
    // 根据位置translationX 设置view2透视的角度 变换
    [self view2_AnimationWithTranslationX:translation.x];
    
    

    
    
    
}

// 根据位置translationX 设置view1透视的角度 变换
- (void)view1_AnimationWithTranslationX:(CGFloat)translationX
{
    if (numeratorView1 < 12) {
        // 降低速度
        CGFloat view1Factor = 10.0;
        numeratorView1 += translationX/view1Factor;
    }else{
        numeratorView1 += translationX;
    }
    
    if (numeratorView1 >= 180) {
        // 趋近于PI / 180时,view1 恢复平整,趋近于零度
        numeratorView1 = 180;
    }
    // PI/2
    if (numeratorView1 < 6) {
        numeratorView1 = 6;
    }
    
    [self transform3d_view1_angle:M_PI/numeratorView1];
}

// 根据位置translationX 设置view2透视的角度 变换
- (void)view2_AnimationWithTranslationX:(CGFloat)translationX
{
    
    // view2 为-6 到 -180的区间
    if (numeratorView2 < -12) {
        // 降低速度
        CGFloat view2Factor = 1.0;
        numeratorView2 += translationX*view2Factor;
    }else{
        numeratorView2 += translationX;
    }
    
    if (numeratorView2 < -180) {
        numeratorView2 = -180;
    }
    
    // PI/2 ok
    if (numeratorView2 > -6) {
        numeratorView2 = -6;
    }
    
    // 1.3D变形
    [self view2AnimationWithAngle:M_PI/numeratorView2];
    // 2.位置平移 -180 ~  -6
    // 设置中心点坐标
    CGFloat n = numeratorView2;
    CGFloat x = (38 * (180 + n))/174.0 + 160;
    
    NSLog(@"sg___x:%f",x);
//    _view2.center = CGPointMake(x, _view2.center.y);
    
}

// 根据位置translationX 设置view1透视的角度 变换
- (void)view2AnimationWithAngle:(CGFloat)translationX
{
//    // v2  3D变换
    [self transform3d_view2_angle:M_PI/numeratorView2];
    
    
//    // v2 平移
//    CGPoint view2center = _view2.center;
//    view2center.x += translation.x;
//    if (view2center.x > (320 - 22)) {
//        view2center.x = 320 - 22;
//    }
//    _view2.center = view2center;
}


//#pragma mark - view2的变形
- (void)transform3d_view2_angle:(CGFloat )angle
{
    CALayer *layer = [_view2 layer];
    CGPoint oldAnchorPoint = layer.anchorPoint;
    
    // 向下,向右 为正;此时锚点在左边中点
    [layer setAnchorPoint:CGPointMake(1, 0.5)];
    
    // 根据新旧锚点,移动图层的坐标位置
    CGFloat posX = layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x);
    CGFloat posY = layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y);
    
    [layer setPosition:CGPointMake(posX,posY)];
    
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    
    // 由于上面整个图层向右边移动了,所以此时,这个相机位置的X值,应该左移一段距离,到中心位置;240为图片的宽
    _view2.layer.transform = CATransform3DPerspect2(rotate, CGPointMake(-200/2.0, 0), 160);
    
    
    
    
}
- (IBAction)backBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


