//
//  UIView+SPExtension.m
//  SPPictureBrowser
//
//  Created by shinephe on 2017/7/19.
//  Copyright © 2017年 shinephe. All rights reserved.
//

#import "UIView+SPExtension.h"

@implementation UIView (SPExtension)

#pragma mark -sp_size
- (void)setSp_size:(CGSize)sp_size {
    
    CGRect frame = self.frame;
    frame.size = sp_size;
    self.frame = frame;

}
- (CGSize)sp_size {
   
    return self.frame.size;

}

#pragma mark -sp_x
- (void)setSp_x:(CGFloat)sp_x {
    
    CGRect frame = self.frame;
    frame.origin.x = sp_x;
    self.frame = frame;

}
- (CGFloat)sp_x {
    
    return self.frame.origin.x;

}

#pragma mark -sp_y
- (void)setSp_y:(CGFloat)sp_y{
   
    CGRect frame = self.frame;
    frame.origin.y = sp_y;
    self.frame = frame;

}
- (CGFloat)sp_y {
    
    return self.frame.origin.y;

}

#pragma mark -sp_width
- (void)setSp_width:(CGFloat)sp_width {
   
    CGRect frame = self.frame;
    frame.size.width = sp_width;
    self.frame = frame;

}
- (CGFloat)sp_width {
   
    return self.frame.size.width;

}

#pragma mark -sp_height
- (void)setSp_height:(CGFloat)sp_height {
  
    CGRect frame = self.frame;
    frame.size.height = sp_height;
    self.frame = frame;

}
- (CGFloat)sp_height {
    
    return self.frame.size.height;

}

#pragma mark -sp_centetX
- (void)setSp_centerX:(CGFloat)sp_centerX {
   
    CGPoint center = self.center;
    center.x = sp_centerX;
    self.center = center;

}
- (CGFloat)sp_centerX {
    
    return self.center.x;

}

#pragma mark -sp_centetY
- (void)setSp_centerY:(CGFloat)sp_centerY {
    
    CGPoint center = self.center;
    center.y = sp_centerY;
    self.center = center;
    
}
- (CGFloat)sp_centerY {
    
    return self.center.y;
    
}

#pragma mark -sp_origin
- (void)setSp_origin:(CGPoint)sp_origin {
    
    CGRect frame = self.frame;
    frame.origin = sp_origin;
    self.frame = frame;

}
- (CGPoint)sp_origin {
    
    return self.frame.origin;
    
}

@end
