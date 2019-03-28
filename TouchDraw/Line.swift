//
//  Line.swift
//  TouchDraw
//
//  Created by Faical Sawadogo1212 on 03/25/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//
//

import UIKit

class Line: NSObject {
    var begin = CGPoint(x: 0.0, y: 0.0)
    var end   = CGPoint(x: 0.0, y: 0.0)
    
    init(begin: CGPoint, end:CGPoint)
    {
        self.begin = begin
        self.end   = end
    }
    
    // This is not necessary, explained in class
    func setTheEnd(end:CGPoint)
    {
        self.end = end
    }
}
