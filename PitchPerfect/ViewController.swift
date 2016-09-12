//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Raghav Khurana on 08/09/16.
//  Copyright © 2016 Raghav Khurana. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var StartRecordingButton: UIButton!
    @IBOutlet weak var StopRecordingButton: UIButton!
    @IBOutlet weak var recordlabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    
    
    @IBAction func RecordAudio(sender: AnyObject) {
        print("Record Button Pressed")
        recordlabel.text = "Recording in progress"
        StopRecordingButton.enabled = true
        StartRecordingButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StopRecordingButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StopRecording(sender: AnyObject) {
        recordlabel.text = "Tap to Record"
        StopRecordingButton.enabled = false
        StartRecordingButton.enabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View Will appear called")
        StopRecordingButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Avrecorder has finished recording")
        if (flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Save record failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

