//
//  ViewController.swift
//  net9
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
    @IBAction func actionSheet(_ sender: Any) {
        let alert = UIAlertController(title: "Action sheet", message: "this is an action sheet", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Red", style: .destructive, handler: {(action) in print("on clicked")
            self.view.backgroundColor = UIColor.red
        }))
        alert.addAction(UIAlertAction(title: "Yellow", style: .default, handler: {(action) in print("on clicked")
            self.view.backgroundColor = UIColor.yellow
        }))
        alert.addAction(UIAlertAction(title: "Green", style: .default, handler: {(action) in print("destructive clicked")
            self.view.backgroundColor = UIColor.green
        }))
        alert.addAction(UIAlertAction(title: "White", style: .cancel, handler: {(action) in print("cancle clicked")
            self.view.backgroundColor = UIColor.white
        }))
        
        present(alert,animated: true,completion: nil)
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        let alert = UIAlertController(title: "Login", message: "Please input your personal information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: {(action) in
            if let userNameTextFiled = alert.textFields?.first,let passwordTextFiled = alert.textFields?.last{
                print("username:\(userNameTextFiled.text!) password:\(passwordTextFiled.text!)")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: {(action) in}))
        alert.addTextField{(textFiled) in
            textFiled.placeholder = "your user name?"
        }
        alert.addTextField{(textFiled) in
            textFiled.placeholder = "your password?"
            textFiled.isSecureTextEntry = true
        }
        present(alert,animated: true,completion: nil)
        
        
    }
    
    
}

