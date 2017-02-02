//
//  AudioRecorderExtension.swift
//  PitchPerfect
//
//  Created by Shani on 1/31/17.
//  Copyright © 2017 Shani Rivers. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: AV Delegate Extension
// Protocal Conformance

extension RecordSoundsViewController: AVAudioRecorderDelegate {

  
  // Stop audio implementation
  func stopRecorder() {
    audioRecorder.stop()
    try! audioSession.setActive(false)
  }
  
  
  // Record audio implementation
  func recordAudio() {
    // record audio
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
    print(filePath!) // so can see the file
  
    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
}
