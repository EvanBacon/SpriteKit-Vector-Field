//
//  LineMoverNode.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import SpriteKit

class LineMoverNode:MoverNode {
    fileprivate var line:SKShapeNode!
    
    override init() {
        super.init()
        
        line = SKShapeNode()
        line.lineWidth = 10
        line.lineCap = .round
        line.lineJoin = .miter
        line.fillColor = UIColor.red
        line.strokeColor = UIColor.red
        self.addChild(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LineMoverNode {
    override func updatePath() {
        let ref = CGMutablePath()
        ref.move(to: origin)
        ref.addLine(to: endPoint)
        
        line.path = ref
    }
}
