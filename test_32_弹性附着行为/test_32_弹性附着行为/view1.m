//
//  view1.m
//  test_32_弹性附着行为
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "view1.h"
@interface view1()
{
    UIImageView *box;
    UIDynamicAnimator *animator;
    UIOffset offset;
    UIImageView *imv;
    UIAttachmentBehavior *attach;
}
@end
@implementation view1
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.png"]];
        box=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.png"]];
        box.center=self.center;
        [self addSubview:box];
        
        animator=[[UIDynamicAnimator alloc]initWithReferenceView:self];
        
        
        offset=UIOffsetMake(50, 50);
        attach=[[UIAttachmentBehavior alloc]initWithItem:box offsetFromCenter:offset attachedToAnchor:CGPointMake(box.center.x, box.center.y-100)];
        attach.damping=1;
        attach.frequency=1;
        [animator addBehavior:attach];
        
        
        UICollisionBehavior *collision=[[UICollisionBehavior alloc]init];
//        collision.translatesReferenceBoundsIntoBoundary=YES;
        [animator addBehavior:collision];

        
        UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
        [animator addBehavior:gravity];

        [collision addItem:box];
        [gravity addItem:box];
        
        
        imv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3.png"]];
        imv.center=CGPointMake(box.bounds.size.width/2+offset.horizontal,box.bounds.size.height/2+offset.vertical );
        [box addSubview:imv];
        
        
        
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesTure:)];
        [self addGestureRecognizer:pan];
        
        
        
        [box addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)panGesTure:(UIPanGestureRecognizer *)sender
{
    if (sender.state==UIGestureRecognizerStateChanged) {
        
        CGPoint po=[sender locationInView:self];
        attach.anchorPoint=po;
        [self setNeedsDisplay];
    }
}
-(void)drawRect:(CGRect)rect
{
    
    CGPoint point=[self convertPoint:imv.center fromView:box];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, attach.anchorPoint.x, attach.anchorPoint.y);
    CGFloat length[2]={5,5};
    CGContextSetLineDash(context, 0.0, length, 2);
    CGContextSetLineWidth(context, 5);
    [[UIColor blackColor]set];
    CGContextStrokePath(context);
    
}
//画线
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}










@end
