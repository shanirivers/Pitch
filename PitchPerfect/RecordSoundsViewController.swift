//
//  RecordSoundsViewControllerViewController.swift
//  PitchPerfect
//
//  Created by Shani on 1/28/17.
//  Copyright © 2017 Shani Rivers. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController{

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         stopButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setUIState(isRecording: Bool, recordingText: String)
    {
       //
        if isRecording == true {
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            recordingLabel.text = recordingText
        } else {
            stopButton.isEnabled = false
            recordButton.isEnabled = true
            recordingLabel.text = recordingText
        }
    }

    @IBAction func recordAudio(_ sender: Any) {
        
        // change label and record button
        setUIState(isRecording: true, recordingText: "Recording in progress")
        
        // record audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!) // so can see the file 
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        
        // change label and stop button
        setUIState(isRecording: false, recordingText: "Tap to Record")

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance() // sets it to inactive
        try! audioSession.setActive(false)
     
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
     
        if flag {
            // perform segue and send the url (location) of the recording
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
               print("recording not saved")
        }
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
           
        }
    }

}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
  
}
