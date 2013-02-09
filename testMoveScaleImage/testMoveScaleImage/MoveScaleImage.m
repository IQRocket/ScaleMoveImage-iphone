//
//  MoveScaleImage.m
//  testMoveScaleImage
//
//  Created by  on 13-2-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MoveScaleImage.h"

@implementation MoveScaleImage

@synthesize myScrollView;
@synthesize myImageView;

-(void)dealloc{
    //[myScrollView release];
  //  [myImageView release];
    //[super dealloc];
    myScrollView=nil;
    myImageView=nil;
}


-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(110, 200, 100, 50)];
    //    [btn setFrame:CGRectMake(110, 200, 100, 40)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"点击查看图片" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)clickEvent:(id)sender{
    NSLog(@"***********clickeventad");
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(self.myScrollView==nil)
    {
        UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.myScrollView=scrollView;
    }
    self.myScrollView.backgroundColor=[UIColor blueColor];
    self.myScrollView.delegate=self;
    self.myScrollView.multipleTouchEnabled=YES;
    self.myScrollView.minimumZoomScale=1.0;
    self.myScrollView.maximumZoomScale=10.0;
    [self.view addSubview:self.myScrollView];
    
    UIImage *_image = [UIImage imageNamed:@"QQ.png"];
    CGFloat imageView_X = (_image.size.width > self.view.frame.size.width) ? self.view.frame.size.width : _image.size.width;
    CGFloat imageView_Y=(_image.size.height > self.view.frame.size.height) ? self.view.frame.size.height : _image.size.height;
    CGFloat origin;
    //保持图片的比例
    if(_image.size.width > self.view.frame.size.width){
        origin = self.view.frame.size.width/_image.size.width;
        imageView_Y = _image.size.height*origin;
    }
    
    myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-imageView_X)/2, (self.view.frame.size.height-imageView_Y)/2, imageView_X, imageView_Y)];
    
    if(self.myImageView==nil)
    {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.myImageView=imageView;
    }
    
    
    UIImage *originImage=[[UIImage alloc]initWithCGImage:_image.CGImage];
    [myImageView setImage:originImage];
    //    [myImageView setFrame:CGRectMake(0, 0, _image.size.width, _image.size.height)];
    
    [self.myScrollView addSubview:self.myImageView];
    
    //返回按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [closeBtn setBackgroundColor:[UIColor redColor]];
    [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn setAlpha:0.5];
    [closeBtn addTarget:self action:@selector(closeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
}


-(void)closeEvent:(id)sender{
    [self.myImageView setHidden:YES];
    [self.myScrollView setHidden:YES];
}

#pragma mark UIScrollView delegate methods
//实现图片的缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"**************viewForZoomingInScrollView");
    return self.myImageView;
}


//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.myImageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
