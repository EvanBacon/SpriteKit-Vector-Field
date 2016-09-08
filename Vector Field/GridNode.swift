//
//  GridNode.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import SpriteKit


class GridNode:SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(size:Int, padding:CGFloat) {
        
        
        
        
        
        self.init(texture:nil, color: UIColor.greenColor(), size: CGSize(width: CGFloat(size - 1) * padding, height: CGFloat(size - 1) * padding))
        
        self.anchorPoint = CGPoint()
        for i in 0..<size {
            let a = CGPoint(x: CGFloat(i) * (padding), y: 0)
            let b = CGPoint(x: CGFloat(i) * (padding), y: self.size.height)
            let node = LineNode(
                a: a,
                b: b
            )
            //            node.position = a + (b/2)
            self.addChild(node)
        }
        for i in 0..<size {
            let a = CGPoint(x: 0, y: CGFloat(i) * (padding))
            let b = CGPoint(x: self.size.width, y: CGFloat(i) * (padding))
            let node = LineNode(
                a: a,
                b: b
            )
            //            node.position = a + (b/2)
            
            self.addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LineNode:SKShapeNode {
    var ref = CGPathCreateMutable()
    
    convenience init(a:CGPoint, b:CGPoint) {
        self.init()
        
        ref = CGPathCreateMutable()
        CGPathMoveToPoint(ref, nil, a.x, a.y)
        
        CGPathAddLineToPoint(ref, nil, b.x, b.y)
        self.path = ref
    }
    
    override init() {
        super.init()
        
        lineWidth = 2
        strokeColor = UIColor.whiteColor()
        fillColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
