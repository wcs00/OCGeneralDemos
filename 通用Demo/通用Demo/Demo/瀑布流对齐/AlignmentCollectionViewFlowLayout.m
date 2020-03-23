//
//  AlignmentCollectionViewFlowLayout.m
//  CollectionViewAlignmentFlowLayout
//
//  Created by Wcs on 2020/3/13.
//  Copyright © 2020 wcs. All rights reserved.
//

#import "AlignmentCollectionViewFlowLayout.h"

@interface AlignmentCollectionViewFlowLayout()

@end
@implementation AlignmentCollectionViewFlowLayout
- (instancetype)initWithAlignmentType:(AlignmentType)alignmentType verticalSpace:(CGFloat)verticalSpace {
    self = [super init];
    if (self) {
        self.type = alignmentType;
        self.verticalSpace = verticalSpace;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * unadjustedAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc]initWithArray:unadjustedAttributes copyItems:YES];
    
    // 存放同一行的attributesa的临时数组
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < layoutAttributes.count; i++) {
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = i == 0 ? nil : layoutAttributes[i-1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = i + 1 == layoutAttributes.count ?
        nil : layoutAttributes[i+1];//下一个cell 位置信息
               
        [tempArray addObject:currentAttr];

        // 根据Y轴判断是不是同一行
        CGFloat previousY = previousAttr == nil ? 0 :CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        
        // 自成一行
        if (currentY != previousY && currentY != nextY) {
            if (![currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader] && ![currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                [self resetLayotAttributeArray:[NSMutableArray arrayWithArray:tempArray]];
            }
            [tempArray removeAllObjects];

        } else if (currentY != nextY) { // 当前位置信息已经是本行最后一个位置信息
            [self resetLayotAttributeArray:[NSMutableArray arrayWithArray:tempArray]];
            [tempArray removeAllObjects];
        }
    }
    return layoutAttributes;
}
  
- (void)resetLayotAttributeArray:(NSMutableArray *)attributeArray {
    CGFloat sectionInsetLeft = self.sectionInset.left;
    CGFloat sectionInsertRight = self.sectionInset.right;
    CGFloat x = 0;
    switch (self.type) {
        case AlignmentTypeLeft:{
            x = sectionInsetLeft;
            for (NSUInteger i = 0; i < attributeArray.count; i++) {
                UICollectionViewLayoutAttributes *attributes = attributeArray[i];
                CGRect frame = attributes.frame;
                frame.origin.x = x;
                attributes.frame = frame;
                x += frame.size.width + self.verticalSpace;
            }
        }
            break;
        case AlignmentTypeCenter:{
            CGFloat totalWidth = 0;
            CGFloat adjustableWidth = 0;
            for (NSUInteger i = 0; i < attributeArray.count; i++) {
                UICollectionViewLayoutAttributes *attributes = attributeArray[i];
                CGRect frame = attributes.frame;
                totalWidth += frame.size.width;
            }
            totalWidth += (self.verticalSpace) * (attributeArray.count - 1);
            // 可调整的空白区域宽度
            adjustableWidth = self.collectionView.frame.size.width - totalWidth - sectionInsetLeft - sectionInsertRight;
            // 如果左缩进大于显示范围与右缩进的和，也没有意义，反之亦然
            if (sectionInsetLeft > (adjustableWidth + sectionInsertRight) || sectionInsertRight > (adjustableWidth + sectionInsetLeft)) {
                return ;
            }
            // 如果内容大于显示范围，就没有调整的意义，小于才有调整意义
            if (totalWidth < self.collectionView.frame.size.width - sectionInsetLeft  - sectionInsertRight) {
                x = (self.collectionView.frame.size.width - sectionInsetLeft - sectionInsertRight - totalWidth) / 2;
                x += sectionInsetLeft + (sectionInsertRight - sectionInsetLeft) / 2;
                for (NSUInteger i = 0; i < attributeArray.count; i++) {
                    UICollectionViewLayoutAttributes *attributes = attributeArray[i];
                    CGRect frame = attributes.frame;
                    frame.origin.x = x;
                    attributes.frame = frame;
                    x += frame.size.width + self.verticalSpace;
                }
            }
            
        }
            break;
        case AlignmentTypeRight:{
            x = self.collectionView.frame.size.width - sectionInsertRight;
            for (int i = (int)attributeArray.count - 1; i >= 0; i--) {
                UICollectionViewLayoutAttributes *attributes = attributeArray[i];
                CGRect frame = attributes.frame;
                x -= frame.size.width;
                frame.origin.x = x;
                attributes.frame = frame;
                x -= self.verticalSpace;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - setter
- (void)setVerticalSpace:(CGFloat)verticalSpace {
    _verticalSpace = verticalSpace;
    self.minimumInteritemSpacing = verticalSpace;
}
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    [super setMinimumInteritemSpacing:minimumInteritemSpacing];
    _verticalSpace = minimumInteritemSpacing;
}

@end
