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
    let gridSize:Int = 10
    let padding:CGFloat = 50

    var grid:GridNode!
    var nodes:[[MoverNode?]]!
    
    var touchPoint:CGPoint?
    
    override func didMoveToView(view: SKView) {
        buildField()
    }
}

extension GameScene {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            touchPoint = location
            fakeTouch(self.convertPoint(location, toNode: grid))
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            touchPoint = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPoint = nil
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchPoint = nil
    }
    
}

extension GameScene {
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if let location = touchPoint {
            fakeTouch(self.convertPoint(location, toNode: grid))
        } else {
            reset()
        }
    }
    
    func reset() {
        for family in nodes {
            for child in family {
                if let node = child {
                    node.lerpToTarget(1.0, point:node.origin)
                }
            }
        }
    }
    
    
    func fakeTouch(point:CGPoint) {
        
        self.updateCursor(point)
        
        let x = point.x.roundToValue(padding) / Int(padding)
        let y = point.y.roundToValue(padding) / Int(padding)
        
        guard x >= 0 && x < nodes.count else { return }
        guard y >= 0 && y < nodes[x].count else { return }
        
        if let node = nodes[x][y] {
            node.input(nodes, magnitude: 1.0, point:point)
        }
    }
}
extension GameScene {
    
    
    func updateCursor(point:CGPoint) {
        if let cursor = grid.childNodeWithName("cursor") {
            cursor.removeFromParent()
        }
        
        let p = SKShapeNode(circleOfRadius: 10)
        p.fillColor = UIColor.redColor()
        p.position = point
        p.name = "cursor"
        grid.addChild(p)
    }
}
extension GameScene {
    func buildField() {
        nodes = Array(count: gridSize, repeatedValue: Array(count: gridSize, repeatedValue: nil))
        
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
    
    func buildGrid() -> GridNode {
        let grid = GridNode(size: gridSize, padding: padding)
        grid.position = CGPoint(x:CGRectGetMidX(self.frame) - grid.size.width / 2, y:CGRectGetMidY(self.frame) - grid.size.height / 2 )

        return grid
    }
    
    func buildNode(origin:CGPoint, x:Int, y:Int) -> MoverNode {
        return LineMoverNode(index: Index(x: x, y: y), origin: origin, padding: padding)
    }
    
}

extension CGFloat {
    func roundToValue(value:CGFloat) -> Int {
        return Int(value * round(self / value))
    }
}

struct Index {
    let x:Int!
    let y:Int!
    
    func neighbors() -> [Index] {
        var n = [Index]()
        for i in -1...1 {
            for j in -1...1 {
                if !(i == 0 && j == 0) {
                    n.append(Index(x: x + i, y: y + j))
                }
            }
        }
        return n
    }
}


