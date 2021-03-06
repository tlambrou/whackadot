//
//  Grid.swift
//  whackadot
//
//  Created by Tassos Lambrou on 7/6/16.
//  Copyright © 2016 Tassos & Jenny Inc. All rights reserved.
//

import Foundation
import SpriteKit


class Grid: SKSpriteNode {
    
    /* Grid array dimensions */
    let rows = 8
    let columns = 8
    
    /* Individual cell dimension, calculated in setup*/
    var cellWidth = 0
    var cellHeight = 0
    
    /* Creature Array */
    var gridArray = [[Dot]]()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* There will only be one touch as multi touch is not enabled by default */
        for touch in touches {
            
            /* Grab position of touch relative to the grid */
            let location  = touch.locationInNode(self)
            
            /* Calculate grid array position */
            let gridX = Int(location.x) / cellWidth
            let gridY = Int(location.y) / cellHeight
            
            /* Clearing a dot*/
            let dot = gridArray[gridX][gridY]
            if dot.state != .inactive {
                dot.state = .inactive
            }
            
            
        }
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch implementation for this node */
        userInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        /* Populate grid with creatures */
        populateGrid()
    }
    
    func populateGrid() {
        /* Populate the grid with creatures */
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Initialize empty column */
            gridArray.append([])
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Create a new creature at row / column position */
                addDotAtGrid(x:gridX, y:gridY)
            }
        }
    }
    
    func addDotAtGrid(x x: Int, y: Int) {
        //Initialize a new dot object
        let dot = Dot()
        
        
        //Convert the row/column position into a grid screen position
        let gridPosition = CGPoint(x: x*cellWidth, y: y*cellHeight)
        dot.position = gridPosition
        
        dot.xScale = CGFloat((320.0/CGFloat(rows))/(60.0))
        dot.yScale = CGFloat((320.0/CGFloat(columns))/(60.0))
        
        print(dot.xScale)
        print(dot.yScale)
        
        //Add dot as a child of the grid node
        addChild(dot)
        
        //Add dot to the gridArray at the x,y position
        gridArray[x].append(dot)
        
        
    }
    
    func addDotToEmptyGrid() {
        var dotCreated: Bool = false
        var xRand = Int.random(columns)
        var yRand = Int.random(rows)
        var dot = gridArray[xRand][yRand]
        var index = 0
        
        while dotCreated == false {
            if dot.state == .inactive {
                let colorRand = Int.random(3)+1
                switch colorRand {
                //case 0?
                case 1:
                    dot.state = .color1
                case 2:
                    dot.state = .color2
                case 3:
                    dot.state = .color3
                default:
                    print("switch statement in addDotToEmptyGrid didn't work")
                }
                
                dotCreated = true
            } else if dot.state != .inactive && index < rows*columns{
                xRand = Int.random(columns)
                yRand = Int.random(rows)
                dot = gridArray[xRand][yRand]
                index += 1
                print(index)
            } else {
                break
            }
            
        }
    }
}