//
//  AlignmentCollectionViewFlowLayout.h
//  CollectionViewAlignmentFlowLayout
//
//  Created by Wcs on 2020/3/13.
//  Copyright © 2020 wcs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, AlignmentType) {
    AlignmentTypeLeft,      // 左对齐
    AlignmentTypeCenter,    // 中间对齐
    AlignmentTypeRight,     // 右对齐
};
@interface AlignmentCollectionViewFlowLayout : UICollectionViewFlowLayout
/// 对齐类型
@property (nonatomic, assign) AlignmentType type;
/// 竖向间距
@property (nonatomic, assign) CGFloat verticalSpace;

/// 初始化
/// @param alignmentType 对齐类型
/// @param verticalSpace 竖向间距
- (instancetype)initWithAlignmentType:(AlignmentType)alignmentType verticalSpace:(CGFloat)verticalSpace;
@end

NS_ASSUME_NONNULL_END
