//
//  MenuVC.swift
//  PROP
//
//  Created by Conder Shou on 3/31/17.
//  Copyright © 2017 ADI Labs. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func unwindModal(segue : UIStoryboardSegue) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toMain(segue: UIStoryboardSegue) {
        print("Unwind segue made")
    }



}
