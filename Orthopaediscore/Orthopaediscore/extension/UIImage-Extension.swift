//
//  UIImage-Extension.swift
//  UBIEAT
//
//  Created by S.t on 16/8/13.
//  Copyright © 2016年 UBIELIFE Inc. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIImage{
    
    class func ImageFromVideo(url: URL) -> UIImage? {
        
        let asset = AVURLAsset.init(url: url)
        
        let imgGenerator = AVAssetImageGenerator.init(asset: asset)
        
        imgGenerator.appliesPreferredTrackTransform = true
        
        let timePoint = CMTimeMake(0, 10)
        
        do{
            let cgImage = try imgGenerator.copyCGImage(at: timePoint, actualTime: nil)
            
            return UIImage.init(cgImage: cgImage)
        }
        catch{
            return nil
        }        
    }
    
    // 这个方法用来 获取 该路径下的 图片大小， 单位 Byte
    class func SizeOfImageIn(path: String) -> UInt64{
        do{
            let item = try FileManager.default.attributesOfItem(atPath: path)
            // 单位是 Byte, iOS 中 1K = 1000 B
            let fileSize = item[FileAttributeKey.size] as! UInt64
            let size = fileSize
            return size
            
        }
        catch{
            return 0
        }
    }
    class func imageFromBase64String(_ base64String: String) -> UIImage?{
        
        var str = base64String
        
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: ",").last else{
                return nil
            }
            str = newBase64String
        }
        
        guard let imgNSData = Data.init(base64Encoded: str, options: NSData.Base64DecodingOptions()) else{
            return nil
        }
        
        guard let image = UIImage.init(data: imgNSData) else{
            return nil
        }
        
        return image
    }
    
    func imageScale(size: CGSize ) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
