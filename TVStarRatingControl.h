//
//  TVStarRatingControl.h
//  TVExample
//
//  Created by zhoujr on 15/12/25.
//  Copyright © 2015年 Topvogues. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 星星评分控件
 * 默认不响应用户事件，如需要可调用 TVStarRatingControl.enabled = YES
 * 使用Actioin-Target方式发送事件，评分变更时，会发送UIControlEventValueChanged事件
 */
@interface TVStarRatingControl : UIControl

@property (nonatomic) IBInspectable CGFloat score;          ///< 评分范围[0, 1], default is 0
@property (nonatomic) IBInspectable NSInteger starCount;    ///< default is 5
@property (nonatomic, getter=isRatingAnimated) IBInspectable BOOL ratingAnimated;    ///< 评分变更时，是否使用动画，default is NO

@property (nonatomic) IBInspectable UIImage *foregroundImage;   ///< 前景图
@property (nonatomic) IBInspectable UIImage *backgroundImage;   ///< 背景图

@end

@interface TVStarRatingControl (Extensions)

/**
 * 设置整数评分
 * @param score 当前评分
 * @param totalScore 总分
 * @note 最终评分 = score / totalScore
 */
- (void)setScore:(CGFloat)score totalScore:(CGFloat)totalScore;

@end
