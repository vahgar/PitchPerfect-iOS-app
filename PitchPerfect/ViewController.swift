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
    
    
    
    @IBAction func RecordAudio(_ sender: AnyObject) {
        print("Record Button Pressed")
        recordlabel.text = "Recording in progress"
        StopRecordingButton.isEnabled = true
        StartRecordingButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray) 
        
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StopRecording(_ sender: AnyObject) {
        recordlabel.text = "Tap to Record"
        StopRecordingButton.isEnabled = false
        StartRecordingButton.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Will appear called")
        StopRecordingButton.isEnabled = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Avrecorder has finished recording")
        if (flag){
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Save record failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

