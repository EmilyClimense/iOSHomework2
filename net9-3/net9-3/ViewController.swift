//
//  ViewController.swift
//  net9-3
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 at. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIScrollViewDelegate{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 1...7{
            let imageView = UIImageView(image: UIImage(named: "\(i)"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: CGFloat(i-1)*scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(imageView)
            scrollView.isPagingEnabled = true
            pageControl.numberOfPages = 7
            pageControl.currentPage = 0
        }
        
        scrollView.contentSize = CGSize(width: 7*scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}


