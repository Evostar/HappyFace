//
//  FaceView.swift
//  HappyFace
//
//  Created by davidforlove on 12/5/14.
//  Copyright (c) 2014 davidforlove. All rights reserved.
//

import UIKit

//var scale = CGFloat()

class FaceView: UIView{

//var scale = 9.0
  

func drawCircleAtPoint(p:CGPoint, radius:CGFloat, context:CGContextRef) {
        
        //var context:CGContextRef = UIGraphicsGetCurrentContext();
        var startAngle: Float = Float(2 * M_PI)
        var endAngle: Float = 0.0
        // startAngle = startAngle - Float(M_PI_2)
        //endAngle = endAngle - Float(M_PI_2)
        UIGraphicsPushContext(context);
        CGContextBeginPath(context);
        CGContextAddArc(context, p.x, p.y, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 0);
        CGContextStrokePath(context)
        UIGraphicsPopContext()
      //  CGContextDrawPath(context, kCGPathStroke)
    }
    let default_scale:CGFloat = 0.90
    
override func drawRect(rect: CGRect) {
        // Drawing code
    
   // var midPoint = CGPoint(x: 0.0, y: 0.0)
    
    // initial
    var midPoint = CGPoint()
    var context:CGContextRef = UIGraphicsGetCurrentContext()
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2
    var size = self.bounds.size.width / 2;
    if self.bounds.size.height < self.bounds.size.width {
        size = self.bounds.size.height / 2}
    size += default_scale
    //  size *= self.scale; // scale is percentage of full view size
    CGContextSetLineWidth(context, 5.0);
    // [[UIColor blueColor] setStroke];
    UIColor.blueColor().setStroke()
    drawCircleAtPoint(midPoint, radius: size, context: context)

    //http://stackoverflow.com/questions/24108827/swift-numerics-and-cgfloat-cgpoint-cgrect-etc?rq=1
    let EYE_H:CGFloat = 0.35
    let EYE_V:CGFloat = 0.35
    let EYE_RADIUS:CGFloat = 0.10
    
    var eyePoint = CGPoint()
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    
  drawCircleAtPoint(eyePoint, radius:size * EYE_RADIUS, context:context); // left eye
    eyePoint.x += size * EYE_H * 2;
  drawCircleAtPoint(eyePoint,radius: size * EYE_RADIUS, context: context) // right eye

    let MOUTH_H:CGFloat = 0.45
    let MOUTH_V:CGFloat = 0.40
    let MOUTH_SMILE:CGFloat = 0.25
    
     var mouthStart = CGPoint()
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    var mouthEnd:CGPoint = mouthStart;
    mouthEnd.x += MOUTH_H * size * 2;
    var mouthCP1:CGPoint = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    var mouthCP2:CGPoint = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    var smile:CGFloat = 1.0; // this should be delegated! it's our View's data!
    
    var smileOffset:CGFloat = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP2.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y); // bezier curve
    CGContextStrokePath(context);
    
   
}

    

}
