//
//  DrawView.swift
//  TouchDraw

//  Created by Faical Sawadogo1212 on 03/25/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import UIKit

class DrawView: UIView {
    // Containers to hold lines underway and lines completed
    var linesInProgress : [Int : Line] = [ : ]
    var completedLines  : [Line]       = [ ]
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        // Iterate through the touch objects
        for touch: UITouch in touches {
            // If we have a double touch clear and return
            if touch.tapCount > 1 {
                // Clear the screen
                clearAll()
                return
            }
            
            // Use the touch's hash value as the key so we can look it up
            // Recall, the touch objects are retained and reused
            let key = touch.hash
            
            // Get the location of the touch
            let loc = touch.location(in: self)
            
            // This is the initial touch so the start and end are the same
            let newLine = Line(begin:loc, end:loc)
            
            // Store in the in-progress container
            linesInProgress[key] = newLine
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            // Get the hash/key for the dictionary lookup
            let key = touch.hash
            
            // Get a reference to the line in the dictionary
            let line = linesInProgress[key]
            
            // Get the location of the touch
            let loc = touch.location(in: self)
            
            // Update the end point
            line?.setTheEnd(end: loc)
        }
        
        // Indicate the view should be redrawn
        self.setNeedsDisplay()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = true
    }
    
    override func draw(_ rect: CGRect) {
        // Get the graphics context
        let context = UIGraphicsGetCurrentContext()!
        
        // Drawing initialization
        context.setLineWidth(10.0)
        context.setLineCap(.round)
        
        // Draw the completed lines in black
        UIColor.black.set()
        for line: Line in completedLines{
            context.move(to: line.begin)
            context.addLine(to: line.end)
            context.strokePath()
        }
        
        // Draw the in-progress lines in red
        UIColor.red.set()
        for line in linesInProgress {
            context.move(to: line.value.begin)
            context.addLine(to: line.value.end)
            context.strokePath()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endTouches(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endTouches(touches: touches)
    }
    
    // Implement endTouches:
    func endTouches(touches: Set<UITouch>) {
        // Go through the touches
        for touch: UITouch in touches {
            // Get the hash/key for the dictionary lookup
            let key = touch.hash
            
            // Get a reference to the line in the dictionary
            let line = linesInProgress[key]
            
            // The line is completed now
            if line != nil {
                // Put the line in with the completed lines and remove from in-progress
                completedLines.append(line!)
                linesInProgress[key] = nil
            }
        }
        
        // Indicate the view should be redrawn
        self.setNeedsDisplay()
    }

    func clearAll() {
        // Clear the containers
        linesInProgress.removeAll()
        completedLines.removeAll()
        
        // Indicate the view should be redrawn
        self.setNeedsDisplay()
    }
}
