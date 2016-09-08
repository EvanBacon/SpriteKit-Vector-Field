//
//  LineMoverNode.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import SpriteKit

class LineMoverNode:MoverNode {
    var line:SKShapeNode!
    
    override func updatePath() {
        let ref = CGPathCreateMutable()
        CGPathMoveToPoint(ref, nil, origin.x, origin.y)
        
        CGPathAddLineToPoint(ref, nil, endPoint.x , endPoint.y)
        line.path = ref
    }
    
    override init() {
        super.init()
        
        line = SKShapeNode()
        line.lineWidth = 10
        line.lineCap = .Round
        line.lineJoin = .Miter
        line.fillColor = UIColor.redColor()
        line.strokeColor = UIColor.redColor()
        self.addChild(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}