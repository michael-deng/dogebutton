//
//  ViewController.swift
//  button
//
//  Created by Yuen Mei Wan on 5/6/15.
//  Copyright (c) 2015 dogetownbuttonmashers. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation

class HomeViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var leaderboard: UIButton!
    
    
//    var score = 0
    var outAppMusic = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outAppMusic = self.setupAudioPlayerWithFile("outApp", type:"mp3")
        
        
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "11207972_10206020159043620_1071044090_o.jpg")!)
//
//        scoreLabel.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        authenticateLocalPlayer(login)
        outAppMusic.play()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2
        var error: NSError?
        
        //3
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4
        return audioPlayer!
    }
    
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "Dogelord") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
            
        }
        
    }
    
    
    //shows leaderboard screen
    @IBAction func showLeader() {
//        var vc = self.view?.window?.rootViewController
        var vc = self
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc.presentViewController(gc, animated: true, completion: nil)
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //initiate gamecenter
    @IBAction func authenticateLocalPlayer(sender:UIButton!){
        
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) {
                self.presentViewController(viewController, animated: true, completion: nil)
            }
                
            else {
                println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }
    
    
}


