//
//  ViewController.swift
//  button
//
//  Created by Yuen Mei Wan on 5/6/15.
//  Copyright (c) 2015 dogetownbuttonmashers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
//    @IBOutlet var button: UIButton!
    
    
//    var globalScore = 0
    var local = 0

    
    
    @IBAction func buttonPressed() {
        local++
        NSLog("\(local)")
        scoreLabel.text = "Score: \(local)"
//        button
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "nyan_cat_wallpaper_by_jeremifier-d3kf4fj.png")!)
        
        scoreLabel.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

