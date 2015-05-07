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

class ViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var score: Int64 = 0
    var scale: CGFloat = 0.2
    
    var inAppMusic = AVAudioPlayer()

    
    @IBAction func buttonPressed() {
        score++
        saveHighscore(score)
        NSLog("\(score)")
        scoreLabel.text = "Score: \(score)"
        saveHighscore(score)
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        getHighScore()
        inAppMusic = self.setupAudioPlayerWithFile("inApp", type:"mp3")
    }
    
    override func viewDidAppear(animated: Bool) {
        scoreLabel.text = "Score: \(score)"
        //inAppMusic.play()
        
//        var strImg : String = "http://i.imgur.com/DTluWB1.gif"
//        
//        var url: NSURL = NSURL(string: strImg)!
//        
//        gif = UIImage.animatedImageWithAnimatedGIFURL(url)

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func saveHighscore(score:Int64) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            println("am i here??")
            
            var scoreReporter = GKScore(leaderboardIdentifier: "Dogelord") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            println("after")
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
            
        }
        
    }
    
    
    //shows leaderboard screen
    func showLeader() {
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
    func authenticateLocalPlayer(){
        
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
    
    
    func getHighScore() {
        let leaderBoardRequest = GKLeaderboard()
        leaderBoardRequest.identifier = "Dogelord"
        
        leaderBoardRequest.loadScoresWithCompletionHandler { (scores, error) -> Void in
            if (error != nil) {
                println("Error: \(error!.localizedDescription)")
                self.score = 0
            } else if (scores != nil) {
                let localPlayerScore = leaderBoardRequest.localPlayerScore
                println("Local player's score: \(localPlayerScore.value)")
                self.score = localPlayerScore.value
            }
        }
    }
}
