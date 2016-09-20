//
//  GameScene.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright (c) 2016 Brix. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let autoReset = true
    let useVectors = true
    let useCursor = false

    let gridSize:Int = 20
    let padding:CGFloat = 20

    var grid:GridNode!
    var nodes:[[MoverNode?]]!
    
    var touchPoint:CGPoint?
    
    
    var velocityField:VelocityFieldNode!
    var velocity:CGPoint?
    
    override func didMove(to view: SKView) {
        velocityField = buildNode()
    }
}

extension SKNode {
    func centerInParent() {
        guard let parent = self.parent else { return }
        position = CGPoint(x:parent.frame.midX, y:parent.frame.midY)
    }
}

extension GameScene {
    func buildField() {
        
        nodes = Array(repeating: Array(repeating: nil, count: gridSize), count: gridSize)
        grid = buildGrid()
        self.addChild(grid)
        
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                let node = buildNode(CGPoint(x: CGFloat(i) * padding, y: CGFloat(j) * padding), x: i, y: j)
                nodes[Int(i)][Int(j)] = node
                grid.addChild(node)
            }
        }
    }
    
    
    func buildNode() -> VelocityFieldNode {
        let grid = VelocityFieldNode(nodes: 100, size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width), gridSize: 30, radius: 50)
        
        self.addChild(grid)
        
        grid.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        grid.centerInParent()
        

        return grid
    }
    
    func buildGrid() -> GridNode {
        let grid = GridNode(size: gridSize, padding: padding)
        grid.position = CGPoint(x:self.frame.midX - grid.size.width / 2, y:self.frame.midY - grid.size.height / 2 )
        
        return grid
    }
    
    func buildNode(_ origin:CGPoint, x:Int, y:Int) -> MoverNode {
        if useVectors {
            return LineMoverNode(index: NodeIndex(x: x, y: y), origin: origin, padding: padding)
        } else {            
            return SpriteMoverNode(index: NodeIndex(x: x, y: y), origin: origin, padding: padding)
        }
    }
    
}

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            
            touchPoint = location
            velocity = CGPoint()

//            fakeTouch(self.convertPoint(location, toNode: grid))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
//            let velocity = abs(location.distanceTo(touchPoint!)) * 0.01
            
            if let tp = touchPoint {
                velocity = location - tp
                touchPoint = location
            }
//            fakeTouch(self.convertPoint(location, toNode: grid), velocity: velocity)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoint = nil
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoint = nil
    }
    
}

extension GameScene {
    
    
    func updateField() {
        if let touchPoint = touchPoint {
            if let velocity = velocity {
                
                let halfNode = CGPoint(x: velocityField.size.width / 2, y: velocityField.size.height / 2)
                let convertedPoint = (self.convert(touchPoint, to: velocityField)) + halfNode
                velocityField.addV(velocity, touchPoint:convertedPoint)
            }
        }
        
        velocityField.update()
    }

    override func update(_ currentTime: TimeInterval) {
        updateField()
        
        /* Called before each frame is rendered */
        if let location = touchPoint {
//            fakeTouch(self.convertPoint(location, toNode: grid))
        } else {
//            reset()
        }
    }
    
    func reset() {
        guard autoReset else { return }
        for family in nodes {
            for child in family {
                if let node = child {
                    node.lerpToTarget(1.0, point:node.origin)
                }
            }
        }
    }
    
    
    func fakeTouch(_ point:CGPoint, velocity:CGFloat=1.0) {
        
        self.updateCursor(point)
        
        var pp = point
        let x = pp.x.roundToValue(padding) / Int(padding)
        let y = pp.y.roundToValue(padding) / Int(padding)
        
        guard x >= 0 && x < nodes.count else { return }
        guard y >= 0 && y < nodes[x].count else { return }
        
        if let node = nodes[x][y] {
            node.input(nodes, magnitude: velocity, point:point)
        }
    }
}
extension GameScene {
    
    
    func updateCursor(_ point:CGPoint) {
        guard useCursor else { return }
        if let cursor = grid.childNode(withName: "cursor") {
            cursor.removeFromParent()
        }
        
        let p = SKShapeNode(circleOfRadius: 10)
        p.fillColor = UIColor.red
        p.position = point
        p.name = "cursor"
        grid.addChild(p)
    }
}


extension CGFloat {
    mutating func roundToValue(_ value:CGFloat) -> Int {
        return Int(value * CGFloat(roundf(Float(self / value))))
    }
}


