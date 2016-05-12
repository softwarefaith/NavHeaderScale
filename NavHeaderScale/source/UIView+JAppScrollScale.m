//
//  UIView+JAppScrollScale.m
//  NavHeaderScale
//
//  Created by 蔡杰Alan on 16/5/12.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "UIView+JAppScrollScale.h"

#import <objc/objc-runtime.h>

@implementation JScrollItem


-(CGFloat)maxSize{
    
    if (_maxSize == 0) {
        
        return self.nomalSize * 1.5;
    }
    return _maxSize;
}


-(CGFloat)minSize{
    if (_minSize == 0) {
        
        return self.nomalSize / 2.0f;
    }
    
    return _minSize;
}

-(CGFloat)nomalSize{
    
    if (_nomalSize == 0) {
        
        return 70.0f;
    }
    return _nomalSize;
}

-(CGFloat)maxDistance{
    
    if (_maxDistance == 0) {
        return 300;
    }
    return _maxDistance;
}

@end

const void * kScrollItemKey = @"kScrollItem";

@implementation UIView (JAppScrollScale)

-(JScrollItem *)scrollItem{
    
    return objc_getAssociatedObject(self, &kScrollItemKey);
}

-(void)setScrollItem:(JScrollItem *)scrollItem{
    
    objc_setAssociatedObject(self, &kScrollItemKey, scrollItem, OBJC_ASSOCIATION_RETAIN);
}

-(void)updateByoffsetY:(CGFloat)offsetY{
    CGFloat scale = 1.0;
    
    if (self.scrollItem == nil) {
        return;
    }
    
    // 放大
    if (offsetY < 0) {
        // 允许下拉放大的最大距离为300
        // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
        // 这个值可以自由调整
        
        CGFloat maxScale = self.scrollItem.maxSize / self.scrollItem.nomalSize;
        
        
        scale = MIN(maxScale, 1 - offsetY / self.scrollItem.maxDistance);
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        
        CGFloat minScale = self.scrollItem.minSize / self.scrollItem.nomalSize;
        
        scale = MAX(minScale, 1 - offsetY /  self.scrollItem.maxDistance);
    }
    
    self.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 保证缩放后y坐标不变
    CGRect frame = self.frame;
    frame.origin.y = -self.layer.cornerRadius / 2;
    self.frame = frame;
}

@end
