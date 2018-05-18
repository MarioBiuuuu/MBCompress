//
//  UIImage+MBCompress.h
//  MBImageCompress
//
//  Created by xiaofeiZhang on 2018/5/18.
//  Copyright © 2018年 xiaofeiZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 压缩边界枚举

 - MBCompressTypeSession: session image boundary is 800, timeline is 1280
 */
typedef NS_ENUM(NSInteger, MBCompressType) {
    MBCompressTypeSession = 0, // 800
    MBCompressTypeTimeline  // 1280
};

@interface UIImage (MBCompress)

/**
 压缩图片

 @param compressType 压缩尺寸边界类型
 @return 压缩后的图片
 */
- (UIImage *)mb_compress:(MBCompressType)compressType;
@end
