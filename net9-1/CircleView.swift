//
//  CircleView.swift
//  net9-1
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 at. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable
class CircleView: UIView {
    
    @IBInspectable var fillColor:UIColor?
    @IBInspectable var strokeColor:UIColor?
    
    func setup(){
        //移动
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        self.addGestureRecognizer(panRecognizer)
        //缩放
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        self.addGestureRecognizer(pinchRecognizer)
        //删除
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        self.addGestureRecognizer(tapRecognizer)
        
        
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 2
        
        //旋转
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotation(recognizer:)))
        self.addGestureRecognizer(rotationRecognizer)
        
    }
    
    //旋转
    @objc func rotation(recognizer: UIRotationGestureRecognizer){
        switch recognizer.state {
        case .recognized:
            print("rotation clicked")
            
        default:
            break
        }
    }
    
    //删除
    @objc func tap(recognizer: UITapGestureRecognizer){
        switch recognizer.state {
        case .recognized:
            print("double clicked")
            
        default:
            break
        }
    }
    
    //缩放
    @objc func pinch(recognizer: UIPinchGestureRecognizer){
        switch recognizer.state {
        case .changed:
            fallthrough
        case .ended:
            bounds.size = CGSize(width: bounds.width*recognizer.scale, height: bounds.height*recognizer.scale)
            recognizer.scale = 1
        default:
            break
        }
    }
    
    //移动
    @objc func pan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .changed:
            fallthrough
        case .ended:
            let translation = recognizer.translation(in: self)
            center.x += translation.x
            center.y += translation.y
            recognizer.setTranslation(.zero, in: self)
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor?.setFill()
        strokeColor?.setStroke()
        
        path.fill()
        path.stroke()
    }
    
}

