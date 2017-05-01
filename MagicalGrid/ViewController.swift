//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Aaron Liu on 5/1/17.
//  Copyright © 2017 Aaron Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let numViewPerRow = 15
    var hashMap = [String:UIView]()
    var selectedCell: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width/CGFloat(numViewPerRow)
        for j in 0...150 {
            for i in 0...numViewPerRow{
                let square = UIView()
                square.backgroundColor = randomColor()
                square.layer.borderColor = UIColor.black.cgColor
                square.layer.borderWidth = 0.5
                square.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j)*width, width: width, height: width)
                view.addSubview(square)
                let key = "\(i)|\(j)"
                hashMap[key] = square
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let width = view.frame.width/CGFloat(numViewPerRow)
        let i = Int(location.x/width)
        let j = Int(location.y/width)
        let key = "\(i)|\(j)"
        guard let cellView = hashMap[key] else {return}
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        selectedCell = cellView
    
        view.bringSubview(toFront: cellView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }



}

