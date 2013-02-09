//
//  MoveScaleImage.h
//  testMoveScaleImage
//
//  Created by  on 13-2-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveScaleImage : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    UIImageView* myImageView;
}

@property(retain,nonatomic)UIScrollView* myScrollView;
@property(retain,nonatomic)UIImageView* myImageView;

@end
