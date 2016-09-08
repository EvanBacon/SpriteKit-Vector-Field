//
//  SpriteMoverNode.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import SpriteKit
class SpriteMoverNode:MoverNode {
    var node:SKSpriteNode!
    
    override func updatePath() {
        node.position = endPoint
    }
    
    override init() {
        super.init()
        node = SKSpriteNode(imageNamed: "snowflake")
        node.size = CGSize(width: 20, height: 20)
        self.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

