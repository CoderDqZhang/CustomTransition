//
//  ViewController.swift
//  CustomTransition
//
//  Created by Zhang on 2017/2/28.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ZDQTranstion.shareManager.animationType = .Default
        self.view.backgroundColor = UIColor.blue
        self.navigationController?.delegate = ZDQTranstion.shareManager

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushViewController(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(OneViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
