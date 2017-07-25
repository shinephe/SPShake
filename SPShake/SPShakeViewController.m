//
//  SPShakeViewController.m
//  SPShake
//
//  Created by shinephe on 2017/7/20.
//  Copyright © 2017年 shinephe. All rights reserved.
//

#import "SPShakeViewController.h"
#import "SPTools.h"
#import "UIView+SPExtension.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SPShakeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *shakeBackgroundImageView;

@property(nonatomic,strong) UIImageView *upImageView;
@property(nonatomic,strong) UIImageView *downImageView;

@property(nonatomic,strong) UIView *upView;
@property(nonatomic,strong) UIView *downView;

@property(strong, nonatomic) CMMotionManager *motionManager;


@end

@implementation SPShakeViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super initWithCoder:aDecoder]) {
        
        _isHaveVoice = YES;
        _isShake = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.upView];
    [self.view addSubview:self.downView];
    
    [self.upView addSubview:self.upImageView];
    [self.downView addSubview:self.downImageView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
    [self startAccelerometerUpdates];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification object:nil];
    [self stopAccelerometerUpdates];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration {
    
    //综合3个方向的加速度
    double accelerameter =sqrt( pow( acceleration.x,2) + pow( acceleration.y,2) + pow( acceleration.z,2) );
    
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if(accelerameter > 2.0f) {
        
        //立即停止更新加速仪（很重要！）
        
        [self stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            
            if (_isShake) {
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            
            if (_isHaveVoice) {
                
                [SPTools playMusic:@"sp_shake_music.mp3"];
            }
            
            [self shaking];
        
        });
    }
}

//重新Push更新
- (void)startAccelerometerUpdates {

    if (self.motionManager.accelerometerAvailable) {
      
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData*accelerometerData,NSError*error) {
            
            [self outputAccelertionData:accelerometerData.acceleration];
            
            if(error) {
                
                NSLog(@"motion error:%@",error);
            }
        }];
    }
}

- (void)setIsShake:(BOOL)isShake {

    _isShake = isShake;
}

- (void)setIsHaveVoice:(BOOL)isHaveVoice {

    _isHaveVoice = isHaveVoice;
}

//停止Push/Pull更新
- (void)stopAccelerometerUpdates {

    [self.motionManager stopAccelerometerUpdates];
}

-(void)receiveNotification:(NSNotification *)notification {
   
    if ([notification.name
         isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        [self.motionManager stopAccelerometerUpdates];
    }
    else {

        [self startAccelerometerUpdates];
    }
}

- (void)shaking {
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.upView.sp_y = -100;
        self.downView.sp_y = SCREEN_HEIGHT*0.5+100;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
           
            [self performSelector:@selector(delayMethod) withObject:self afterDelay:0.35];
        }
    }];
}

- (void)delayMethod {
    
    [UIView animateWithDuration:0.35 animations:^{
       
        self.upView.sp_y = 0;
        self.downView.sp_y = SCREEN_HEIGHT*0.5;
   
    } completion:^(BOOL finished) {
        
        if (finished) {

            [self startAccelerometerUpdates];

            NSLog(@"动画结束了");
            
            NSLog(@"开始请求网络");
        }
    }];
}

- (UIImageView *)upImageView {
    
    if (!_upImageView) {
        
        _upImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sp_shake_up"]];
        _upImageView.frame = CGRectMake((SCREEN_WIDTH-100)*0.5, SCREEN_HEIGHT*0.5-60, 100, 60);
    }
    return _upImageView;
}

- (UIImageView *)downImageView {
    
    if (!_downImageView) {
        
        _downImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sp_shake_down"]];
        _downImageView.frame = CGRectMake((SCREEN_WIDTH-100)*0.5, 0, 100, 60);
    }
    return _downImageView;
}

- (UIView *)upView {
   
    if (!_upView) {
        
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
        _upView.backgroundColor = [UIColor blackColor];
    }
    
    return _upView;
}

- (UIView *)downView {

    if (!_downView) {
        
        _downView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
        _downView.backgroundColor = [UIColor blackColor];
    }
    return _downView;
}

- (CMMotionManager *)motionManager {
    
    if (!_motionManager) {
        
        _motionManager= [[CMMotionManager alloc]init];
        
        _motionManager.accelerometerUpdateInterval =.1;
    }
    return _motionManager;
}

@end
