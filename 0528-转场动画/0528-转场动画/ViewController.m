//
//  ViewController.m
//  0528-转场动画
//
//  Created by lanou3g on 15/5/28.
//  Copyright (c) 2015年 伊卡洛斯. All rights reserved.
//

#import "ViewController.h"
#define DURATION 0.7f
#define IMAGE ([NSString stringWithFormat:@"%d.jpg",(arc4random()%8 + 1)])

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *transitionSegment;

@end

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBgImageWithImageName:IMAGE];
    self.segmentedControl.selectedSegmentIndex = 3;
    self.transitionSegment.selectedSegmentIndex = 0;
}
- (IBAction)tapButton:(id)sender {
    
    UIButton *button = sender;
    AnimationType animationType = button.tag;
    
    NSString *subtypeString;
    
    switch (_transitionSegment.selectedSegmentIndex) {
        case 0:
            subtypeString = kCATransitionFromTop;
            break;
        case 1:
            subtypeString = kCATransitionFromLeft;
            break;
        case 2:
            subtypeString = kCATransitionFromBottom;
            break;
        case 3:
            subtypeString = kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CurlDown:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
    
    [self addBgImageWithImageName:IMAGE];
    
}



#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    CAMediaTimingFunction *timingFunction;
    
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
        case 1:
            timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case 2:
            timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 3:
            timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
            
        default:
            break;
    }
    animation.timingFunction = timingFunction;
    [view.layer addAnimation:animation forKey:@"animation"];
}



#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:_transitionSegment.selectedSegmentIndex];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}



#pragma 给View添加背景图
-(void)addBgImageWithImageName:(NSString *) imageName
{
    self.view.layer.contents = (id)[UIImage imageNamed:imageName].CGImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
