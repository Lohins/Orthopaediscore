//
//  UIView-Extension.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-08-15.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//
import UIKit

extension UIView{
    
    var width: CGFloat{
        get{
            return self.frame.width
        }
        set{
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.height)
        }
    }
    
    var height: CGFloat{
        get{
            return self.frame.height
        }
        set{
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: newValue)
        }
    }
    
    var left: CGFloat{
        get{
            return self.frame.origin.x
        }
        
        set{
            self.frame = CGRect(x: newValue, y: self.frame.origin.y, width: self.width, height: self.height)
        }
    }
    
    var right: CGFloat{
        get{
            return self.frame.origin.x + self.width
        }
        set{
            self.frame = CGRect(x: newValue - self.width, y: self.frame.origin.y, width: self.width, height: self.height)
        }
    }
    
    var top: CGFloat{
        get{
            return self.frame.origin.y
        }
        
        set{
            self.frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    var bottom: CGFloat{
        get{
            return self.frame.origin.y + self.height
        }
        set{
            self.frame = CGRect(x: self.frame.origin.x, y: newValue  - self.height, width: self.width, height: self.height)
        }
    }
    
    func getCurrentViewController() -> UIViewController?{
        var nextResponder = self.next
        while nextResponder != nil{
            if let nextResponder = nextResponder  {
                if nextResponder.isKind(of: UIViewController.classForCoder()) {
                    return nextResponder as? UIViewController
                }
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
}
