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
    
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    @IBOutlet weak var stopButton: UIButton!
    var stopTimer: Timer!
    
    enum ButtonType: Int {case slow = 0, fast, darth, chipmunk, echo, reverb }
    

    
    @IBAction func playSoundForButton(_ sender: AnyObject) {
        print("Play Sound")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .darth:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopSoundforButton(_ sender: AnyObject) {
        print("Stop Sound")
        stopAudio()
    }
      override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
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
