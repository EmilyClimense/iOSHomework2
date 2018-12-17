//
//  ViewController.swift
//  net9-1
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 at. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //增加
    @IBAction func addLabel(_ sender: Any) {
        let x = Int(arc4random()) % Int(view.bounds.width)
        let y = Int(arc4random()) % Int(view.bounds.height)
        
        let label = UILabel(frame: CGRect(x: x, y: y, width: 30, height: 30))
        label.text = "A"
        label.textAlignment = .center
        label.backgroundColor = UIColor.red
        
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 5, height: 5)
        label.layer.shadowOpacity = 1
        view.addSubview(label)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        label.addGestureRecognizer(panRecognizer)
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotation(recognizer:)))
        label.addGestureRecognizer(rotationRecognizer)
        
        label.isUserInteractionEnabled = true
        
    }
    //移动
    @IBAction func moveLabel(_ sender: Any) {
        for label in view.subviews{
            if label is UILabel{
                UIView.animate(withDuration: 1){
                    let x = Int(arc4random()) % Int(self.view.bounds.width)
                    let y = Int(arc4random()) % Int(self.view.bounds.height)
                    label.center.x = CGFloat(x)
                    label.center.y = CGFloat(y)
                }
                
            }
        }
        
    }
    
    //删除
    @IBAction func deleteLabel(_ sender: Any) {
        for label in view.subviews{
            if label is UILabel{
                label.removeFromSuperview()
            }
        }
    }
    
    // 旋转
    @objc func rotation(recognizer: UIRotationGestureRecognizer){
        switch recognizer.state {
        case .recognized:
            print("rotation clicked")
            
        default:
            break
        }
    }
    
    // 移动
    @objc func pan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .changed:
            fallthrough
        case .ended:
            let translation = recognizer.translation(in: self.view)
            recognizer.view?.center.x += translation.x
            recognizer.view?.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.view)
        default:
            break
        }
    }
    
    
    
}


