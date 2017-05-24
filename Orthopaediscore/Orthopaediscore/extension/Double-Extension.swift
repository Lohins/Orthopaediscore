//
//  Double-Extension.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-09-23.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//

import UIKit

extension Double {
    func getPriceFormat() -> String{
        return String.init(format: "$%.2f", self)
    }
}
