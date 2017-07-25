//
//  UIView+SPExtension.h
//  SPPictureBrowser
//
//  Created by shinephe on 2017/7/19.
//  Copyright © 2017年 shinephe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SPExtension)

@property(nonatomic,assign) CGFloat sp_x;                    //About UI.frame.origin.x
@property(nonatomic,assign) CGFloat sp_y;                    //About UI.frame.origin.y
@property(nonatomic,assign) CGFloat sp_centerX;              //About UI.center.x
@property(nonatomic,assign) CGFloat sp_centerY;              //About UI.center.y
@property(nonatomic,assign) CGFloat sp_width;                //About UI.frame.size.width
@property(nonatomic,assign) CGFloat sp_height;               //About UI.frame.size.height
@property(nonatomic,assign) CGSize  sp_size;                 //About UI.frame.size
@property(nonatomic,assign) CGPoint sp_origin;               //About UI.frame.origin

@end
