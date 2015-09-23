//
//  ViewController.swift
//  FTGradientLabelDemo
//
//  Created by Bill on 15/8/4.
//  Copyright (c) 2015年 Fittime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     @IBOutlet weak var rainbowLabel: FTGradientLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testlabel = FTGradientLabel(frame: CGRectMake(0, 0, 200, 50))
        testlabel.text = "Helloworld"
        testlabel.font = UIFont(name: "Helvetica", size: 41)
        testlabel.gradientStartPoint = CGPointMake(0, 1)
        testlabel.gradientEndPoint = CGPointMake(1, 0)
        testlabel.center = view.center
        testlabel.gradientColors = [UIColor.redColor(),UIColor.yellowColor()]
        self.view.addSubview(testlabel)
        
        rainbowLabel.gradientStartPoint = CGPointMake(0, 0)
        rainbowLabel.gradientEndPoint = CGPointMake(1, 1)
        rainbowLabel.gradientColors = [UIColor.redColor(),UIColor.yellowColor(),UIColor.greenColor(),UIColor.cyanColor(),UIColor.blueColor(),UIColor.purpleColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

