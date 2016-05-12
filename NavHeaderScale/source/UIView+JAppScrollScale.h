//
//  UIView+JAppScrollScale.h
//  NavHeaderScale
//
//  Created by 蔡杰Alan on 16/5/12.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JScrollItem : NSObject

@property (nonatomic,assign) CGFloat nomalSize;

@property (nonatomic,assign) CGFloat maxSize;

@property (nonatomic,assign) CGFloat minSize;

@property (nonatomic,assign) CGFloat maxDistance;

@end


@interface UIView (JAppScrollScale)


@property(nonatomic,strong)JScrollItem *scrollItem;


-(void)updateByoffsetY:(CGFloat)offsetY;

@end
