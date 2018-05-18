//
//  UIImage+MBCompress.m
//  MBImageCompress
//
//  Created by xiaofeiZhang on 2018/5/18.
//  Copyright © 2018年 xiaofeiZhang. All rights reserved.
//

#import "UIImage+MBCompress.h"

@implementation UIImage (MBCompress)

/**
 压缩图片
 
 @param compressType 压缩尺寸边界类型， session image boundary is 800, timeline is 1280
 @return 压缩后的图片
 */
- (UIImage *)mb_compress:(MBCompressType)compressType {
    
    CGSize size = [self mb_imageSize:compressType];
    UIImage *reImage = [self mb_resizedImage:size];
    NSData *data = UIImageJPEGRepresentation(reImage, 0.5);
    return [UIImage imageWithData:data];
}

/**
 获取压缩的尺寸

 @param compressType 压缩尺寸边界类型， session image boundary is 800, timeline is 1280
 @return 压缩尺寸
 */
- (CGSize)mb_imageSize:(MBCompressType)compressType {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat boundary = 1280;
    if (width < boundary || height < boundary) {
        return CGSizeMake(width, height);
    }
    
    int s = MAX(width, height) / MIN(width, height);
    if (s <= 2) {
        int x = MAX(width, height) / boundary;
        if (width > height) {
            width = boundary;
            height = height / x;
        } else {
            height = boundary;
            width = width / x;
        }
    } else {
        if (MIN(width, height) >= boundary) {
            boundary = compressType == MBCompressTypeSession ? 800 : 1280;
            int x = MIN(width, height) / boundary;
            if (width < height) {
                width = boundary;
                height = height / x;
            } else {
                height = boundary;
                width = width / x;
            }
        }
    }
    
    return CGSizeMake(width, height);
}

/**
 压缩图片至指定尺寸

 @param size 指定尺寸
 @return 压缩后的图片
 */
- (UIImage *)mb_resizedImage:(CGSize)size {
    CGRect newRect =CGRectMake(0, 0, size.width, size.height);
    UIImage *newImage = nil;
    UIGraphicsBeginImageContext(newRect.size);
    newImage = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:self.imageOrientation];
    [newImage drawInRect:newRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
