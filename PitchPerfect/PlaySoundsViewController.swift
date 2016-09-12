//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Raghav Khurana on 09/09/16.
//  Copyright © 2016 Raghav Khurana. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var chipmunk: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var DarthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabitButton: UIButton!
    
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    @IBOutlet weak var stopButton: UIButton!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {case Slow = 0, Fast, Darth, Chipmunk, Echo, Reverb }
    

    
    @IBAction func playSoundForButton(sender: AnyObject) {
        print("Play Sound")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Darth:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopSoundforButton(sender: AnyObject) {
        print("Stop Sound")
        stopAudio()
    }
      override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
