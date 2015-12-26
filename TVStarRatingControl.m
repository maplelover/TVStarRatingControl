//
//  TVStarRatingControl.m
//  TVExample
//
//  Created by zhoujr on 15/12/25.
//  Copyright © 2015年 Topvogues. All rights reserved.
//

#import "TVStarRatingControl.h"

@interface TVStarRatingControl ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation TVStarRatingControl

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _starCount = 5;
    self.enabled = NO;
}

- (void)setScore:(CGFloat)score
{
    [self setScore:score notify:NO];
}

- (void)setScore:(CGFloat)score notify:(BOOL)notify
{
    if (_score != score)
    {
        _score = score;
        [self updateStarForegroundView];
        
        if (notify)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (UIView *)starBackgroundView
{
    if (!_starBackgroundView)
    {
        _starBackgroundView = [self buildStarViewWithImage:self.backgroundImage];
        _starBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_starBackgroundView];
    }
    return _starBackgroundView;
}

- (UIView *)starForegroundView
{
    if (!_starForegroundView)
    {
        _starForegroundView = [self buildStarViewWithImage:self.foregroundImage];
        [self addSubview:_starForegroundView];
    }
    return _starForegroundView;
}

- (UIImage *)backgroundImage
{
    if (!_backgroundImage)
    {
        _backgroundImage = [UIImage imageNamed:@"common_star_gray"];
    }
    return _backgroundImage;
}

- (UIImage *)foregroundImage
{
    if (!_foregroundImage)
    {
        _foregroundImage = [UIImage imageNamed:@"common_star"];
    }
    return _foregroundImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateStarForegroundView];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    [self changeStarForegroundViewWithPoint:point];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self isTouchInside])
    {
        CGPoint point = [touch locationInView:self];
        [self changeStarForegroundViewWithPoint:point];
    }
    
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGFloat left = fminf(fmaxf(point.x, 0), self.width);
    [self setScore:left / self.width notify:YES];
}

- (void)updateStarForegroundView
{
    [self starBackgroundView]; // make sure background view is created firstly
    
    if ([self isRatingAnimated])
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.starForegroundView.width = self.score * self.width;
        }];
    }
    else
    {
        self.starForegroundView.width = self.score * self.width;
    }
}

- (UIView *)buildStarViewWithImage:(UIImage *)image
{
    NSParameterAssert(self.starCount > 0);
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    view.userInteractionEnabled = NO;
    view.clipsToBounds = YES;
    
    CGFloat imageWidth = self.width / self.starCount;
    
    for (int i = 0; i < self.starCount; ++i)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setContentMode:UIViewContentModeCenter];
        imageView.frame = CGRectMake(i * imageWidth, 0, imageWidth, self.height);
        [view addSubview:imageView];
    }
    
    return view;
}

@end

@implementation TVStarRatingControl (Extensions)

- (void)setScore:(CGFloat)score totalScore:(CGFloat)totalScore
{
    self.score = score / totalScore;
}

@end
