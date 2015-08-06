FTGradientLabel
=====================

![FTGradientLabel](https://github.com/billxie1988/FTGradientLabel/blob/master/FTGradientLabelDemo/Screen_Shot.png)


## Make UILabel Gradient

### Version 1.0.0


---
If you like FTGradientLabel and use it, could you please:

 * star this repo 
 * send me some feedback. Thanks!


------------------------------------

Basic usage
====================================
```objective-c
add "FTGradientLabel.swift" to your proj


- (void)viewDidLoad()
{
    ... ...
       
    var testlabel = FTGradientLabel(frame: CGRectMake(0, 0, 200, 50))
        testlabel.text = "Helloworld"
        testlabel.font = UIFont(name: "Helvetica", size: 41)
        testlabel.gradientStartPoint = CGPointMake(0, 0)
        testlabel.gradientEndPoint = CGPointMake(1, 1)
        testlabel.center = view.center
        testlabel.gradientColors = [UIColor.redColor(),UIColor.yellowColor()]
        self.view.addSubview(testlabel)
}

```

-------

Misc
=======

Author: BillXie

-------
#### License
This code is distributed under the terms and conditions of the MIT license. 

-------
#### Contribution guidelines

If you are fixing a bug you discovered, please add also a unit test so I know how exactly to reproduce the bug before merging.
