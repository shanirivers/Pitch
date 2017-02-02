//
//  RecordSoundsViewControllerViewController.swift
//  PitchPerfect
//
//  Created by Shani on 1/28/17.
//  Copyright © 2017 Shani Rivers. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    var audioRecorder: AVAudioRecorder!
    var audioSession = AVAudioSession.sharedInstance() // See AudioRecorderExtension file for implementation
    
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

  // MARK: UI
    func setUIState(isRecording: Bool, recordingText: String)
    {
       // sets UI state
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

  //MARK: IBActions
    @IBAction func recordAudio(_ sender: Any) {
      // change label and record button
      setUIState(isRecording: true, recordingText: "Recording in progress")
        
      // record audio
      recordAudio()
  }
    
    
    @IBAction func stopRecording(_ sender: Any) {
      // change label and stop button
      setUIState(isRecording: false, recordingText: "Tap to Record")
      
      // stop the recorder 
      stopRecorder()
    }

  // MARK: - Segue Implementation -
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
     
        if flag {
            // perform segue and send the url (location) of the recording
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
          let alert = UIAlertController(title: "Recording Error", message: "The recording was not saved.", preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
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
