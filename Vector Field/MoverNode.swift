//
//  MoverNode.swift
//  Vector Field
//
//  Created by Evan Bacon on 9/8/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import SpriteKit

class MoverNode:SKNode {
    var index:Index!
    var padding:CGFloat!
    
    var origin:CGPoint = CGPointZero {
        didSet {
            self.endPoint = origin
        }
    }
    
    var endPoint:CGPoint = CGPointZero {
        didSet {
            updatePath()
        }
    }
    
    
    convenience init(index:Index, origin:CGPoint, padding:CGFloat) {
        self.init()
        self.index = index
        self.origin = origin
        self.padding = padding
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoverNode {
    func updatePath() {
    }
    
    func fieldGet(data:[[MoverNode?]], index:Index) -> MoverNode? {
        guard index.x >= 0 && index.x < data.count else { return nil }
        guard index.y >= 0 && index.y < data[index.x].count else { return nil }
        return data[index.x][index.y]
        
    }
    
    
    func neighbors(data:[[MoverNode?]]) -> [MoverNode] {
        var neighbors:[MoverNode] = []
        
        for n in index.neighbors() {
            if let node = fieldGet(data, index: n) {
                neighbors.append(node)
                //                print("append:", n.x, n.y)
            }
        }
        return neighbors
    }
    
    func input(data:[[MoverNode?]], magnitude:CGFloat, point:CGPoint) -> [Index] {
        var childrenIndexes:[Index] = [index]
        
        var copy = data
        
        copy[index.x][index.y] = nil
        
        let lerpAmount:CGFloat = 0.8
        
        lerpToTarget(magnitude, point: point, amount: lerpAmount)
        
        let lerpVal = magnitude * lerpAmount
        
        if lerpVal < 0.1 {
            return childrenIndexes
        }
        let neighboringNodes = neighbors(copy)
        
        for node in neighboringNodes {
            for childIndex in node.input(copy, magnitude: lerpVal, point: point) {
                copy[childIndex.x][childIndex.y] = nil
                childrenIndexes.append(childIndex)
            }
        }
        
        return childrenIndexes
    }
    
    func lerpToTarget(magnitude:CGFloat, point:CGPoint, amount:CGFloat=0.8) {
        let target = origin.cartesian((point - origin).angle, radius: min(point.distanceTo(endPoint) * amount, padding/3))
        
        endPoint = lerp(start: endPoint, end: target, t: 0.1)
    }
}
