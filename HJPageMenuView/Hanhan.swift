//
//  Hanhan.swift
//  ScrollViewVC
//
//  Created by 王木木 on 16/11/22.
//  Copyright © 2016年 王木木. All rights reserved.
//

import UIKit

class Hanhan: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let btn = UIView.init(frame: CGRect.init(x: 30,
                                                 y: 100,
                                                 width: view.frame.size.width - 100,
                                                 height: 50))
        
        
        btn.backgroundColor = UIColor.red
        
        view.addSubview(btn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
