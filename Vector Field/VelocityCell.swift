//
//  VelocityCell.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/9/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import Foundation

import SpriteKit

class VelocityCell: NSObject {
    
    var arrowNode:ArrowNode!
    var frame:CGRect!
    var innerPoint:DynamicIndex!
    var wSize:CGSize!
    var cellSize:CGSize!
    
    var left:Int!, right:Int!, top:Int!, bottom:Int!;
    
    var velocity:CGPoint = CGPoint()
    
    var diffV:CGPoint = CGPoint();
    var arrowScale:Float   = 30;
    var arrowSize:Float = 2;
    var arrowLength:Float!;
    var cellW:Float!, cellH:Float!
    var cellsWidth:Int!, cellsHeight:Int!
    
    
    override init() {
        super.init()
    }
    
    convenience init(frame:CGRect, interPoint:DynamicIndex, wSize:CGSize, cellSize:CGSize, offset:CGPoint) {
        self.init()
        self.arrowNode = ArrowNode()
        self.arrowNode.position = offset
        arrowNode.origin = frame.origin
        self.frame = frame
        self.innerPoint = interPoint
        self.wSize = wSize
        self.cellSize = cellSize
        
        findSides()
        
    }
    
    
    private func findSides() {
        let x = innerPoint.x
        let y = innerPoint.y
        
        if (x == 0) {
            left = Int(cellSize.width - 1);
        } else {
            left = x - 1;
        }
        
        if (x == Int(cellSize.width - 1) ) {
            right = 0;
        } else {
            right = x + 1;
        }
        
        if (y == 0) {
            top = Int(cellSize.height) - 1;
        } else {
            top = y - 1;
        }
        
        if (y == Int(cellSize.height) - 1 ) {
            bottom = 0;
        } else {
            bottom = y + 1;
        }
    }
    
    func addV(a:CGPoint) {
        velocity += a
    }
    
    func update(friction:CGFloat) {
        render()
        velocity = velocity * friction
        
        diffV = velocity
        diffV *= 0.025
        velocity *= 0.9
    }
    
    func render() {
        arrowNode.endPoint = arrowNode.origin.cartesian(velocity.angle, radius: velocity.length())
    }
}