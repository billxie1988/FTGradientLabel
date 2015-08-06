//
//  ViewController.swift
//  FTGradientLabelDemo
//
//  Created by Bill on 15/8/4.
//  Copyright (c) 2015年 Fittime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       var testlabel = FTGradientLabel(frame: CGRectMake(0, 0, 200, 50))
        testlabel.text = "Helloworld"
        testlabel.font = UIFont(name: "Helvetica", size: 41)
        testlabel.gradientStartPoint = CGPointMake(0, 0)
        testlabel.gradientEndPoint = CGPointMake(1, 1)
        testlabel.center = view.center
        testlabel.gradientColors = [UIColor.redColor(),UIColor.yellowColor()]
        self.view.addSubview(testlabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

