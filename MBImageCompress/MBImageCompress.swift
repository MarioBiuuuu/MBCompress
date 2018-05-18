//
//  MBImageCompress.swift
//  MBImageCompress
//
//  Created by xiaofeiZhang on 2018/5/18.
//  Copyright © 2018年 xiaofeiZhang. All rights reserved.
//

import Foundation
import UIKit

public enum MBCompressType {
    case session
    case timeline
}

public extension UIImage {
    
    func mb_compress(compressType: MBCompressType = .timeline) -> UIImage {
        let size = self.mb_imageSize(compressType: compressType)
        let reImage = self.mb_resizedImage(size: size)
        let data = UIImageJPEGRepresentation(reImage, 0.5)!
        return UIImage.init(data: data)!
    }
    
    /**
     压缩图片
     
     @param compressType 压缩尺寸边界类型， session image boundary is 800, timeline is 1280
     @return 压缩后的图片
     */
    private func mb_imageSize(compressType: MBCompressType) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        var boundary: CGFloat = 1280
        
        guard width > boundary || height > boundary else {
            return CGSize(width: width, height: height)
        }
        
        let s = max(width, height) / min(width, height)
        if s <= 2 {
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
            } else {
                height = boundary
                width = width / x
            }
        } else {
            if min(width, height) >= boundary {
                boundary = compressType == .session ? 800 : 1280
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                } else {
                    height = boundary
                    width = width / x
                }
            }
        }
        return CGSize(width: width, height: height)
    }
    
    private func mb_resizedImage(size: CGSize) -> UIImage {
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var newImage: UIImage!
        UIGraphicsBeginImageContext(newRect.size)
        newImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation: self.imageOrientation)
        newImage.draw(in: newRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}
