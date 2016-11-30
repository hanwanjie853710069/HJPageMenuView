//
//  ViewController.swift
//  ScrollViewVC
//
//  Created by 王木木 on 16/11/22.
//  Copyright © 2016年 王木木. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var controllerArray : [UIViewController] = []
        
                for _ in 0...10 {
        
        let vc = Hanhan()
        
        controllerArray.append(vc)
        
                }
    
        let parameters: [TSPageMenuOption] = [.BottomViewColor(UIColor.red),
                                              .MenuBackColor(UIColor.brown),
                                              .MenutitleColor(UIColor.orange)
                                              ]
        
        let frame = CGRect.init(x: 0,
                                y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.height)
        
        let pageMenu =  TSHJPageMenu(viewControllers: controllerArray,
                                     frame: frame,
                                     pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu)
        
        self.view.addSubview(pageMenu.view)
        
        pageMenu.view.frame = self.view.frame
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

